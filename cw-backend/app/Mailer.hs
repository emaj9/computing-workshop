module Mailer where

import Control.Concurrent ( forkIO, ThreadId, killThread )
import Control.Concurrent.Chan
import Control.Monad
import Network.HaskellNet.SMTP
import Network.HaskellNet.SMTP.SSL
import System.Timeout

-- | Five seconds.
timeoutDuration = 5000000

data MailInfo
  = MailInfo
    { mailInfoCommand :: SMTPConnection -> IO ()
    , mailInfoResponse :: Chan ()
    }

data MailerConf
  = MailerConf
    { confUsername :: String
    , confPassword :: String
    , confHostname :: String
    }

-- | A mailer represents a background service to send email.
data Mailer = Mailer (Chan MailInfo) ThreadId

timeoutResponse = timeout timeoutDuration

-- | Submits an email to be sent asynchronously.
-- Returns whether the submission was successful.
-- This does not mean that the email was successfully sent, however!
submitMail :: Mailer -> (SMTPConnection -> IO ()) -> IO Bool
submitMail (Mailer c _) m = do
  c' <- newChan -- response channel
  writeChan c (MailInfo m c')
  maybe False (const True) <$> timeoutResponse (readChan c')

killMailer :: Mailer -> IO ()
killMailer (Mailer _ t) = killThread t

-- | Spawn a new mailer worker.
-- Returns 'Left' with an error message if the mailer cannot be started.
newMailer :: MailerConf -> IO (Either String Mailer)
newMailer MailerConf{..} = do
  conn <- connectSMTPSTARTTLS confHostname
  authenticate PLAIN confUsername confPassword conn >>= \case
    False -> do
      closeSMTP conn
      pure (Left "failed to authenticate")
    True -> do
      c <- newChan
      t <- forkIO $ mailerMain c conn
      pure (Right $ Mailer c t)
  where
    mailerMain c conn = forever $ do
      MailInfo{..} <- readChan c
      writeChan mailInfoResponse () -- send confirmation of submission
      mailInfoCommand conn -- run the request
