module Server where

import Control.Monad.IO.Class
import Control.Concurrent
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import Data.Monoid ( (<>) )
import Data.Aeson
import Data.Text ( Text )
import GHC.Generics
import Servant
import System.IO
import System.Environment

data Env
  = Env
    { envLock :: Lock
    , envOutPath :: FilePath
    }

makeEnv :: IO Env
makeEnv = do
  l <- Lock <$> newMVar ()
  p <- getEnv "CW_BACKEND_OUT_PATH"
  pure Env
    { envLock = l
    , envOutPath = p
    }

newtype Lock = Lock (MVar ())

withLock :: Lock -> IO a -> IO a
withLock (Lock l) m = withMVar l (const m)

server :: Env -> Server CWAPI
server Env{..} = register where
  register reg = do
    liftIO $ registerUser envLock envOutPath reg
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

data Registration
  = Registration
    { registerName :: Text
    , registerEmail :: Text
    , registerBgGeneral :: Text
    , registerBgComputers :: Text
    , registerBgTeaching :: Text
    }
  deriving (Eq, Generic, FromJSON, ToJSON)

data RegistrationRes
  = RegistrationRes
    { registerStatus :: RegisterStatus
    }
  deriving (Eq, Generic, ToJSON)

data RegisterStatus
  = RegisterOk
  | RegisterNotOk
  deriving (Eq, Generic)

instance ToJSON RegisterStatus where
  toJSON x = case x of
    RegisterOk -> "ok"
    RegisterNotOk -> "notok"
