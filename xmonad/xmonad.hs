import XMonad
import XMonad.Hooks.ManageDocks
import System.IO

main = do
    xmproc <- spawn "xmobar "
    xmonad $ docks def
        { modMask = mod4Mask
        , terminal = "xterm"
        }
