{-# LANGUAGE OverloadedStrings #-}

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
  define $ package "fcitx5-material-color"
      `sourceGit` "https://github.com/hosxy/fcitx5-material-color"
      `fetchGitHub` ("hosxy", "fcitx5-material-color")
  define $ package "fcitx5-nord"
      `sourceGit` "https://github.com/tonyfettes/fcitx5-nord"
      `fetchGitHub` ("tonyfettes", "fcitx5-nord")

  define $ package "rime-prelude"
      `sourceGit` "https://github.com/rime/rime-prelude"
      `fetchGitHub` ("rime", "rime-prelude")
  define $ package "rime-cangjie"
      `sourceGit` "https://github.com/rime/rime-prelude"
      `fetchGitHub` ("rime", "rime-prelude")
  define $ package "rime-wubi86-jidian"
      `sourceGit` "https://github.com/KyleBing/rime-wubi86-jidian"
      `fetchGitHub` ("KyleBing", "rime-wubi86-jidian")
  define $ package "rime-japanese"
      `sourceGit` "https://github.com/gkovacs/rime-japanese"
      `fetchGitHub` ("gkovacs", "rime-japanese")

  define $ package "background-image"
      `sourceManual` date
      `fetchUrl` const "https://wiki.haskell.org/wikistatic/haskellwiki_logo.png"

  define $ package "aria-ng"
      `sourceGitHub` ("mayswind", "AriaNg")
      `fetchUrl` (\(Version v) ->
        fromString $
            printf
            "https://github.com/mayswind/AriaNg/releases/download/%s/AriaNg-%s-AllInOne.zip"
            v v)

  define $ package "sddm-slice" `fromGitHub` ("RadRussianRus", "sddm-slice")
  define $ package "sddm-chili" `fromGitHub` ("MarianArlt", "sddm-chili")

  define $ package "vonfry-icon"
      `sourceManual` date
      `fetchUrl` const "https://vonfry.name/static/images/default/logo-white.png";

  define $ package "fortune-chinese"
      `sourceGit` "https://github.com/ruanyf/fortunes.git"
      `fetchGitHub` ("ruanyf", "fortunes")
