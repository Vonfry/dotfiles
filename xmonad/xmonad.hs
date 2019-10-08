import XMonad hiding ((|||))
-- import XMonad.Actions.Submap
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Man
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Window
import XMonad.Layout.ShowWName
import XMonad.Layout.Grid
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.CenteredMaster
import XMonad.Layout.LayoutCombinators
import XMonad.Prompt.Layout
import XMonad.Util.Paste
import qualified XMonad.StackSet as W
import qualified  Data.Map as M
import System.IO

myFont = "xft:Hack:size=8"
myFontCJK = "xft:Source Han Sans CN:size=8"
myModMask = mod4Mask
myTerm = "alacritty"

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

    , ((modm, xK_F1), manPrompt myXPC)

    , ((modm                , xK_Print), spawn "flameshot gui    -p ~/screenshot/")
    , ((modm .|. controlMask, xK_Print), spawn "flameshot screen -p  ~/screenshot/")
    , ((modm .|. shiftMask  , xK_Print), spawn "flameshot full   -p ~/screenshot")

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
    , ((modm .|. shiftMask, xK_g), windowPrompt myXPC Goto allWindows)
    , ((modm .|. controlMask, xK_g), windowPrompt myXPC Goto wsWindows)
    , ((modm .|. shiftMask, xK_b), windowPrompt myXPC Bring allWindows)
    , ((modm .|. controlMask, xK_b), windowPrompt myXPC Bring wsWindows)


    , ((modm,               xK_d), withFocused hideWindow)
    , ((modm .|. shiftMask, xK_d), popOldestHiddenWindow)

    , ((modm, xK_z), gridselectWorkspace myGSConfW W.view)

    , ((modm .|. shiftMask, xK_at), layoutPrompt myXPC)

    , ((modm, xK_p), pasteSelection)

    , ((modm, xK_o), windowMenu)
    ]

myLayout = beforeLayouts layouts
  where
    layouts =
            noBorders (tabbed shrinkText def
                { inactiveBorderColor = "#586e75" -- solarized base01
                , activeBorderColor   = "#586e75" -- solarized base01
                , inactiveTextColor   = "#586e75" -- solarized base01
                , activeTextColor     = "#ffffff" -- solarized white
                , inactiveColor       = "#073642" -- solarized base02
                , activeColor         = "#b58900" -- solarized yellow
                , fontName            = myFontCJK
                , decoHeight          = 24
                })
        ||| Accordion
        ||| tiled
        ||| Mirror tiled
        ||| Grid
        ||| Full
        ||| centerMaster tiled
        ||| centerMaster (Mirror tiled)
        ||| centerMaster Grid
    tiled = Tall 1 (3/100) (1/2)
    beforeLayouts = showWName . hiddenWindows

myDef = def
    { modMask = myModMask
    , terminal = myTerm
    , keys =  myKeys <+> keys def
    , layoutHook = myLayout
    , focusFollowsMouse = False
    , focusedBorderColor = "#268bd2" -- solarized blue
    , normalBorderColor = "#073642" -- solarized base03
    }

main = xmonad myDef
