import XMonad
import qualified XMonad.Prompt as XP
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Layout.ShowWName (showWName)
import qualified XMonad.Layout.ShowWName as XLS
import qualified Data.Map as M
import System.IO

myXPC = XP.def
    { XP.font = "xft:Hack-11"
    }

myKeys conf@(XConfig {modMask = modm}) = M.fromList
    [ ((modm .|. shiftMask, xK_x), shellPrompt myXPC)
    ]

myDef = def
    { modMask = mod4Mask
    , terminal = "xterm"
    , keys =  myKeys <+> keys def
    , layoutHook = showWName $ layoutHook XLS.def
    }

main = xmonad myDef
