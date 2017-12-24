{-# LANGUAGE OverloadedStrings #-}
module Main where

import Hakyll
import System.FilePath
import Text.Pandoc
import Data.Monoid ( (<>) )

--hakyll :: monad -> IO ()

main :: IO ()
main = hakyll $ do
  match "pages/*" $ do
    route $ customRoute myRoute `composeRoutes` (setExtension "html")
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
  match "templates/*" $ compile templateCompiler
  match "css/style.css" $ do
    route idRoute
    compile copyFileCompiler
  match "img/*.jpg" $ do
    route idRoute
    compile copyFileCompiler

myRoute :: (Identifier -> FilePath)
myRoute id = drop 6 (toFilePath id)
