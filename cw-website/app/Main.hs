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
    route $ customRoute (dropRoute 6) `composeRoutes` (setExtension "html")
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match "verbatim-pages/*" $ do
    route $ customRoute (dropRoute 15) `composeRoutes` (setExtension "html")
    compile $ getResourceBody
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match "js/*" $ do
    route idRoute
    compile copyFileCompiler

  match "templates/*" $ compile templateCompiler

  match "css/style.css" $ do
    route idRoute
    compile copyFileCompiler

  match "img/*.jpg" $ do
    route idRoute
    compile copyFileCompiler

dropRoute :: Int -> Identifier -> FilePath
dropRoute n id = drop n (toFilePath id)
