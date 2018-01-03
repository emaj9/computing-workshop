module Main where

import Server
import Servant
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import System.Environment ( lookupEnv )

(<#>) = flip (<$>)
infixr 3 <#>

main :: IO ()
main = do
  env <- makeEnv

  logger <- maybe False ("1" ==) <$> lookupEnv "CW_BACKEND_DEBUG" <#> \case
    False -> logStdout
    True -> logStdoutDev

  putStrLn "Listening on port 8080"
  run 8080 (logger $ serve cwapi (server env))
