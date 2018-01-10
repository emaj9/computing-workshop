module Server where

import Control.Monad.IO.Class
import Control.Concurrent
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import Data.Monoid ( (<>) )
import Data.Aeson
import Data.Text as T
import Data.Text.Lazy as TL
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
    , envMailer :: Mailer
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
  mailer <- newMailer mailerConf >>= \case
    Left msg -> die msg
    Right x -> pure x

  pure Env
    { envLock = l
    , envOutPath = p
    , envMailer = mailer
    }

newtype Lock = Lock (MVar ())

withLock :: Lock -> IO a -> IO a
withLock (Lock l) m = withMVar l (const m)

server :: Env -> Server CWAPI
server Env{..} = register where
  register reg = liftIO $ do
    registerUser envLock envOutPath reg
    submitMail envMailer (sendConfirmationEmails reg)
    pure RegistrationRes
      { registerStatus = RegisterOk
      }

registerUser :: Lock -> FilePath -> Registration -> IO ()
registerUser l fp = withLock l . LBS.appendFile fp . lf . encode where
  lf = (<> "\n")

type CWAPI =
  "register" :> ReqBody '[JSON] Registration :> Post '[JSON] RegistrationRes

cwapi :: Proxy CWAPI
cwapi = Proxy

emailSender :: String
emailSender = "noreply@computing-workshop.com"

emailSubject :: String
emailSubject = "[Computing Workshop] Welcome!"

sendConfirmationEmails :: Registration -> SMTPConnection -> IO ()
sendConfirmationEmails reg@Registration{..} conn = do
  let body = mailBody reg
  sendPlainTextMail (T.unpack registerEmail) emailSender emailSubject body conn

mailBody :: Registration -> TL.Text
mailBody Registration{..} =
  "Dear " <> TL.fromStrict registerName <> ",\n\n" <>
  "We're pleased to have you join Computing Workshop!\n\n" <>
  "Looking forward to meeting you,\n" <>
  "Jacob & Eric\n"
