module XMonad.Config.Vonfry.StartupHook where

import XMonad
import System.Environment (setEnv)

startupHook :: X ()
startupHook =
    io $ setEnv "XDG_SESSION_TYPE" "x11"
