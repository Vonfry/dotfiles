{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE RecordWildCards   #-}

module Update (main) where

import Data.Default (def)
import NvFetcher

import Text.Printf (printf)
import Data.String (fromString)
import Data.Text (Text)

import Data.Time.Clock (getCurrentTime, UTCTime(UTCTime, utctDay))
import Data.Time.Calendar (showGregorian)

data PkgSetArg = PkgSetArg { date :: Text }

main :: IO ()
main = papareArguments >>= runNvFetcher' nvfetcherConfig . packageSet

nvfetcherConfig = def

papareArguments :: IO PkgSetArg
papareArguments = do
     UTCTime { utctDay } <- getCurrentTime
     pure $ PkgSetArg { date = fromString $ showGregorian utctDay
                      }

packageSet (PkgSetArg {..}) = do
  define $ package "fcitx5-nord"
      `sourceGit` "https://github.com/tonyfettes/fcitx5-nord"
      `fetchGitHub` ("tonyfettes", "fcitx5-nord")

  define $ package "rime-prelude"
      `sourceGit` "https://github.com/rime/rime-prelude"
      `fetchGitHub` ("rime", "rime-prelude")
  define $ package "rime-cangjie"
      `sourceGit` "https://github.com/rime/rime-cangjie"
      `fetchGitHub` ("rime", "rime-cangjie")
  define $ package "rime-wubi86-jidian"
      `sourceGit` "https://github.com/KyleBing/rime-wubi86-jidian"
      `fetchGitHub` ("KyleBing", "rime-wubi86-jidian")
  define $ package "rime-japanese"
      `sourceGit` "https://github.com/gkovacs/rime-japanese"
      `fetchGitHub` ("gkovacs", "rime-japanese")

  define $ package "background-image"
      `sourceManual` date
      `fetchUrl` const "https://wiki.haskell.org/wikistatic/haskellwiki_logo.png"

  define $ package "vonfry-icon"
      `sourceManual` date
      `fetchUrl` const "https://vonfry.name/images/default/logo-white.png"

  define $ package "fortune-chinese"
      `sourceGit` "https://github.com/ruanyf/fortunes.git"
      `fetchGitHub` ("ruanyf", "fortunes")

  define $ package "easypulse"
      `sourceGit` "https://github.com/p-chan5/EasyPulse.git"
      `fetchGitHub` ("p-chan5", "EasyPulse")

  define $ package "jackhack96Easyeffects"
      `sourceGit` "https://github.com/JackHack96/EasyEffects-Presets.git"
      `fetchGitHub` ("JackHack96", "EasyEffects-Presets")

  define $ package "web-scout-mcp"
      `sourceGit` "https://github.com/pinkpixel-dev/web-scout-mcp.git"
      `fetchGitHub` ("pinkpixel-dev", "web-scout-mcp")
