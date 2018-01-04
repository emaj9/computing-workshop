module Main where

import Data.Proxy
import qualified Data.ByteString as BS
import Network.HTTP.ReverseProxy
import Network.HTTP.Client ( Manager, defaultManagerSettings, newManager )
import Network.Wai
import Network.Wai.Handler.Warp ( run )
import Network.Wai.Middleware.RequestLogger ( logStdoutDev )
import Servant
import Servant.Utils.StaticFiles
import System.Environment ( getEnv )

forwardRequest :: ProxyDest -> Request -> IO WaiProxyResponse
forwardRequest dest req = do
  pure (WPRModifiedRequest req' dest) where
    req' = req { rawPathInfo = BS.drop 4 (rawPathInfo req) }

-- | This web server forwards api calls to the API server and otherwise serves
-- up a static file from the compiled frontend.
type DebugApi
  = "api" :> Raw
  :<|> Raw

debugApi :: Proxy DebugApi
debugApi = Proxy

main :: IO ()
main = do
  apiPort <- read <$> getEnv "CW_API_PORT"
  frontendPath <- getEnv "CW_FRONTEND_PATH"
  port <- read <$> getEnv "CW_DEBUG_PORT"

  let dest = ProxyDest "localhost" apiPort

  manager <- newManager defaultManagerSettings

  putStrLn $ "Proxy listening on port " ++ show port
  run port $ logStdoutDev $ serve debugApi $ server dest frontendPath manager

server :: ProxyDest -> FilePath -> Manager -> Server DebugApi
server dest frontendPath manager = apiCall :<|> static where
  apiCall :: Tagged Handler Application
  apiCall = Tagged (waiProxyTo (forwardRequest dest) defaultOnExc manager)

  static :: Tagged Handler Application
  static = serveDirectoryWebApp frontendPath
