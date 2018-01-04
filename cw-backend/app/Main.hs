module Main where

import Server
import Servant
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import System.Environment ( lookupEnv, getEnv )

(<#>) = flip (<$>)
infixr 3 <#>

main :: IO ()
main = do
  env <- makeEnv

  logger <- maybe False ("1" ==) <$> lookupEnv "CW_BACKEND_DEBUG" <#> \case
    False -> logStdout
    True -> logStdoutDev

  port <- read <$> getEnv "CW_API_PORT"
  putStrLn $ "Backend listening on port " ++ show port
  run port (logger $ serve cwapi (server env))
