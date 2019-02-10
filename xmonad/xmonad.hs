import XMonad
import XMonad.Actions.Submap
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
import XMonad.Actions.Launcher
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Layout
import XMonad.Layout.ShowWName
import XMonad.Layout.Grid
import XMonad.Layout.Accordion
import qualified XMonad.StackSet as W
import qualified  Data.Map as M
import System.IO

myFont = "xft:Hack-11"
myModMask = mod4Mask
myTerm = "xterm"

myXPC = def
    { font = myFont
    , searchPredicate = fuzzyMatch
    }

myGSC = myGSConf
myGSConf = def
    { gs_font = myFont
    }
myGSConfW = def
    { gs_font = myFont
    }

myKeys conf@(XConfig {modMask = modm}) = M.fromList
    [ ((modm, xK_x         ), shellPrompt  myXPC)
    , ((modm, xK_apostrophe), xmonadPrompt myXPC)
    , ((modm, xK_slash     ), promptSearch myXPC multi)

    , ((modm .|. shiftMask, xK_t), withFocused float)

    , ((modm,               xK_Down),  nextWS)
    , ((modm,               xK_Up),    prevWS)
    , ((modm .|. shiftMask, xK_Down),  shiftToNext)
    , ((modm .|. shiftMask, xK_Up),    shiftToPrev)
    , ((modm,               xK_Right), nextScreen)
    , ((modm,               xK_Left),  prevScreen)
    , ((modm .|. shiftMask, xK_Right), shiftNextScreen)
    , ((modm .|. shiftMask, xK_Left),  shiftPrevScreen)
    , ((modm .|. shiftMask, xK_z),     toggleWS)

    , ((modm, xK_g), goToSelected myGSC)
    , ((modm, xK_b), bringSelected myGSC)
    , ((modm, xK_z), gridselectWorkspace myGSConfW W.view)

    , ((modm .|. controlMask, xK_at), layoutPrompt myXPC)
    , ((modm, xK_o), windowMenu)
    ]

myLayout = Grid ||| Full ||| Accordion ||| layoutHook def

myDef = def
    { modMask = myModMask
    , terminal = myTerm
    , keys =  myKeys <+> keys def
    , layoutHook = myLayout
    }

main = xmonad myDef
