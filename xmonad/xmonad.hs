import XMonad
import XMonad.Actions.Submap
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
import XMonad.Actions.Launcher
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Layout
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Window
import XMonad.Layout.ShowWName
import XMonad.Layout.WindowArranger
import qualified  Data.Map as M
import System.IO

myFont = "xft:Hack-11"
myModMask = mod4Mask

myXPC = def
    { font = myFont
    , searchPredicate = fuzzyMatch
    }

myGSC = def
    { gs_font = myFont
    }

myKeys conf@(XConfig {modMask = modm}) = M.fromList
    [ ((modm, xK_x         ), shellPrompt  myXPC)
    , ((modm, xK_apostrophe), xmonadPrompt myXPC)
    , ((modm, xK_slash     ), promptSearch myXPC multi)

    , ((modm, xK_space), switchLayer)
    , ((modm, xK_l), windowGo R False)
    , ((modm, xK_h), windowGo L False)
    , ((modm, xK_k), windowGo U False)
    , ((modm, xK_j), windowGo D False)
    , ((modm .|. controlMask, xK_l), windowSwap R False)
    , ((modm .|. controlMask, xK_h), windowSwap L False)
    , ((modm .|. controlMask, xK_k), windowSwap U False)
    , ((modm .|. controlMask, xK_j), windowSwap D False)
    , ((modm .|. shiftMask, xK_l), screenGo R False)
    , ((modm .|. shiftMask, xK_h), screenGo L False)
    , ((modm .|. shiftMask, xK_k), screenGo U False)
    , ((modm .|. shiftMask, xK_j), screenGo D False)
    , ((modm .|. shiftMask .|. controlMask, xK_l), screenSwap R False)
    , ((modm .|. shiftMask .|. controlMask, xK_h), screenSwap L False)
    , ((modm .|. shiftMask .|. controlMask, xK_k), screenSwap U False)
    , ((modm .|. shiftMask .|. controlMask, xK_j), screenSwap D False)
    , ((modm .|. mod1Mask, xK_l), windowToScreen R False)
    , ((modm .|. mod1Mask, xK_h), windowToScreen L False)
    , ((modm .|. mod1Mask, xK_k), windowToScreen U False)
    , ((modm .|. mod1Mask, xK_j), windowToScreen D False)

    , ((modm .|. controlMask              , xK_s    ), sendMessage  Arrange         )
    , ((modm .|. controlMask .|. shiftMask, xK_s    ), sendMessage  DeArrange       )
    , ((modm .|. controlMask              , xK_Left ), sendMessage (MoveLeft      1))
    , ((modm .|. controlMask              , xK_Right), sendMessage (MoveRight     1))
    , ((modm .|. controlMask              , xK_Down ), sendMessage (MoveDown      1))
    , ((modm .|. controlMask              , xK_Up   ), sendMessage (MoveUp        1))
    , ((modm                 .|. shiftMask, xK_Left ), sendMessage (IncreaseLeft  1))
    , ((modm                 .|. shiftMask, xK_Right), sendMessage (IncreaseRight 1))
    , ((modm                 .|. shiftMask, xK_Down ), sendMessage (IncreaseDown  1))
    , ((modm                 .|. shiftMask, xK_Up   ), sendMessage (IncreaseUp    1))
    , ((modm .|. controlMask .|. shiftMask, xK_Left ), sendMessage (DecreaseLeft  1))
    , ((modm .|. controlMask .|. shiftMask, xK_Right), sendMessage (DecreaseRight 1))
    , ((modm .|. controlMask .|. shiftMask, xK_Down ), sendMessage (DecreaseDown  1))
    , ((modm .|. controlMask .|. shiftMask, xK_Up   ), sendMessage (DecreaseUp    1))

    , ((modm .|. controlMask, xK_m), layoutPrompt myXPC)
    , ((modm, xK_g), goToSelected myGSC)
    , ((modm, xK_b), bringSelected myGSC)

    , ((modm, xK_o), windowMenu)
    ]

myLayout = windowArrangeAll $ layoutHook def

myNav2D = withNavigation2DConfig def

myDef = def
    { modMask = myModMask
    , terminal = "xterm"
    , keys =  myKeys <+> keys def
    , layoutHook = myLayout
    }

main = xmonad $ myNav2D $ myDef
