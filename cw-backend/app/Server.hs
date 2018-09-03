module Server where

import Control.Monad ( forM_ )
import Control.Monad.IO.Class
import Control.Concurrent
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import Data.Monoid ( (<>) )
import Data.Aeson
import Data.List.Split
import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import Network.HaskellNet.SMTP
import Servant
import System.IO
import System.Environment
import System.Exit

import Mailer
import Types

data Env
  = Env
    { envLock :: Lock
    , envOutPath :: FilePath
    , envMailerConf :: MailerConf
    , envNotificationRecipients :: [String]
    }

makeMailerConf :: IO MailerConf
makeMailerConf = MailerConf
  <$> getEnv "CW_BACKEND_SMTP_USERNAME"
  <*> getEnv "CW_BACKEND_SMTP_PASSWORD"
  <*> getEnv "CW_BACKEND_SMTP_HOSTNAME"

makeEnv :: IO Env
makeEnv = do
  l <- Lock <$> newMVar ()
  p <- getEnv "CW_BACKEND_OUT_PATH"
  mailerConf <- makeMailerConf
  recps <- splitOn "," <$> getEnv "CW_BACKEND_NOTIFY_RECIPIENTS"

  pure Env
    { envLock = l
    , envOutPath = p
    , envMailerConf = mailerConf
    , envNotificationRecipients = recps
    }

newtype Lock = Lock (MVar ())

withLock :: Lock -> IO a -> IO a
withLock (Lock l) m = withMVar l (const m)

server :: Env -> Server CWAPI
server Env{..} = register where
  notifyEmail = notificationEmail envNotificationRecipients

  register reg = liftIO $ do
    registerUser envLock envOutPath reg

    newMailer envMailerConf >>= \case
      Right mailer -> do
        submitMail mailer (sendRegistrationEmail notifyEmail reg)
        submitMail mailer (sendRegistrationEmail welcomeEmail reg)
        pure RegistrationRes
          { registerStatus = RegisterOk
          }
      Left err -> do
        pure RegistrationRes
          { registerStatus = RegisterNotOk
          }

registerUser :: Lock -> FilePath -> Registration -> IO ()
registerUser l fp = withLock l . LBS.appendFile fp . lf . encode where
  lf = (<> "\n")

type CWAPI =
  "register" :> ReqBody '[JSON] Registration :> Post '[JSON] RegistrationRes

cwapi :: Proxy CWAPI
cwapi = Proxy

-- | A formatter for emails.
data RegistrationEmail
  = RegistrationEmail
    { regEmailSubject :: Registration -> String
    , regEmailBody :: Registration -> TL.Text
    , regEmailRecipients :: Registration -> [String]
    }

welcomeEmail :: RegistrationEmail
welcomeEmail = RegistrationEmail
  { regEmailSubject = const "Welcome to Computing Workshop!"
  , regEmailBody = \Registration{..} ->
    "Dear " <> TL.fromStrict registerName <> ",\n\n" <>
    "We're pleased to have you join Computing Workshop!\n\n" <>
    "Looking forward to meeting you,\n" <>
    "Jacob & Eric\n"
  , regEmailRecipients = \Registration{..} -> [T.unpack registerEmail]
  }

notificationEmail :: [String] -> RegistrationEmail
notificationEmail recps = RegistrationEmail
  { regEmailSubject = \Registration{..} ->
    "[CW] New registrant: " <> T.unpack registerName
  , regEmailRecipients = const recps
  , regEmailBody = \Registration{..} -> TL.concat $ map f
    [ ("Name: ", registerName)
    , ("Email: ", registerEmail)
    , ("Background (general): ", registerBgGeneral)
    , ("Questions about computers: ", registerQuestions)
    ]
  } where
    f (fieldName, content) =
      fieldName <> "\n    " <> TL.fromStrict content <> "\n"

sendRegistrationEmail :: RegistrationEmail -> Registration -> SMTPConnection -> IO ()
sendRegistrationEmail RegistrationEmail{..} reg conn = do
  forM_ (regEmailRecipients reg) $ \recp -> do
    sendPlainTextMail recp emailSender (regEmailSubject reg) (regEmailBody reg) conn
  where
    emailSender = "noreply@computing-workshop.com"
