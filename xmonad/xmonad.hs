import XMonad
import XMonad.Hooks.ManageDocks (docks)
import XMonad.Util.Run (spawnPipe)
import System.IO

myDef = def
    { modMask = mod4Mask
    , terminal = "xterm"
    }

main = xmonad myDef
