import XMonad hiding ((|||))
-- import XMonad.Actions.Submap
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Actions.WorkspaceNames
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Man
import XMonad.Layout.ShowWName
import XMonad.Layout.Grid
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Renamed
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
    }

myGSC = myGSConf
myGSConf = def
    { gs_font = myFont
    }
myGSConfW = def
    { gs_font = myFont
    }

myKeys conf@(XConfig {modMask = modm}) = M.fromList
    [ ((modm, xK_x              ), shellPrompt  myXPC)
    , ((modm .|. shiftMask, xK_x), spawnSelected myGSC
        [ "chromium" "VirtualBox" "telegram-desktop" ])
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

    , ((modm,               xK_d), withFocused hideWindow)
    , ((modm .|. shiftMask, xK_d), popOldestHiddenWindow)

    , ((modm, xK_z), gridselectWorkspace myGSConfW W.view)

    , ((modm, xK_colon), renameWorkspace myXPC)

    , ((modm, xK_semicolon), layoutPrompt myXPC)

    , ((modm, xK_p), pasteSelection)

    , ((modm, xK_o), windowMenu)
    ]

myLayout = beforeLayouts layouts
  where
    layouts =
            renamed [ Replace "Tab" ] (noBorders $ tabbed shrinkText def
                { inactiveBorderColor = "#586e75" -- solarized base01
                , activeBorderColor   = "#586e75" -- solarized base01
                , inactiveTextColor   = "#586e75" -- solarized base01
                , activeTextColor     = "#ffffff" -- solarized white
                , inactiveColor       = "#073642" -- solarized base02
                , activeColor         = "#b58900" -- solarized yellow
                , fontName            = myFontCJK
                , decoHeight          = 24
                })
        ||| renamed [ Replace "Accordion" ] Accordion
        ||| renamed [ Replace "Tiled"     ] tiled
        ||| renamed [ Replace "MTiled"    ] (Mirror tiled)
        ||| renamed [ Replace "Grid"      ] Grid
        ||| renamed [ Replace "Full"      ] Full
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
