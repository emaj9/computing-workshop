{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Data.Bool ( bool )
import qualified Data.HashMap.Lazy as M
import Data.Monoid ( (<>) )
import System.FilePath
import Text.Pandoc

import Hakyll

main :: IO ()
main = hakyll $ do
  match "pages/*" $ do
    route $ customRoute (dropRoute 6) `composeRoutes` (setExtension "html")
    compile $ do
      -- select the compilation strategy depending on whether the page is verbatim:
      --  - verbatim -> just read the file
      --  - not verbatim -> use pandoc
      (bool pandocCompiler getResourceBody =<< isVerbatim)
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

  match "lessons/**.pdf" $ do
    route idRoute
    compile copyFileCompiler

  match "lessons/**.ipynb" $ do
    route idRoute
    compile copyFileCompiler

  match "static/**" $ do
    route (customRoute $ dropRoute 7)
    compile copyFileCompiler

  match "dst-fonts/*" $ do
    route $ gsubRoute "dst-fonts" (const "fonts")
    compile copyFileCompiler

  match "templates/*" $ compile templateCompiler

dropRoute :: Int -> Identifier -> FilePath
dropRoute n id = drop n (toFilePath id)

(<#>) = flip (<$>)
infixl 1 <#>

-- | Decides whether the current compilation target is a verbatim
-- target (i.e. should not be processed with pandoc)
isVerbatim :: Compiler Bool
isVerbatim =
  getUnderlying >>= getMetadata <#> M.lookup "verbatim" <#> \case
    Just (Bool True) -> True
    _ -> False
