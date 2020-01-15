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
import XMonad.Layout.ShowWName
import XMonad.Layout.Grid
import XMonad.Layout.Column
import XMonad.Layout.Tabbed
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Renamed
import XMonad.Util.Paste
import qualified XMonad.StackSet as W
import qualified  Data.Map as M
import System.IO

myFont = "xft:Hack:size=9"
myFontCJK = "xft:Source Han Sans CN:size=11"
myFontCJKSmall = "xft:Source Han Sans CN:size=9"
myModMask = mod4Mask
myTerm = "alacritty"
myBrowser = "chromium"

myXPConf = def
    { font = myFont
    }

myGSConf = def
    { gs_font = myFont
    }
myGSConfWs = def
    { gs_font = myFont
    }
myGSConfS = def
    { gs_font = myFont
    }


myKeys conf@(XConfig {modMask = modm}) = M.fromList
    [ ((modm, xK_x), shellPrompt  myXPConf)
    , ((modm, xK_comma), runSelectedAction myGSConfS
        [ ("zeal"       , spawn "zeal"               )
        , ("browser"    , spawn myBrowser            )
        , ("libreoffice", spawn "libreoffice"        )
        , ("virtualbox" , spawn "VirtualBox"         )
        , ("viewer"     , spawn "zathura"            )
        , ("telegram"   , spawn "telegram-desktop"   )
        ]
      )
    , ((modm, xK_dollar), runSelectedAction myGSConfS
        [ ("poweroff"    , spawn "poweroff"         )
        , ("suspend"     , spawn "systemctl suspend")
        , ("reboot"      , spawn "reboot"           )
        , ("halt"        , spawn "halt"             )
        ]
      )
    , ((modm, xK_apostrophe), xmonadPrompt myXPConf      )
    , ((modm, xK_slash     ), promptSearch myXPConf multi)

    , ((modm              , xK_i), spawn "alacritty -e ranger")
    , ((modm .|. shiftMask, xK_i), spawn "emacs"              )

    , ((modm                , xK_Print), spawn "flameshot gui    -p ~/screenshot/" )
    , ((modm .|. controlMask, xK_Print), spawn "flameshot screen -p  ~/screenshot/")
    , ((modm .|. shiftMask  , xK_Print), spawn "flameshot full   -p ~/screenshot"  )

    , ((modm .|. shiftMask, xK_t), withFocused float)

    , ((modm,               xK_Down  ), nextWS          )
    , ((modm,               xK_Up    ), prevWS          )
    , ((modm .|. shiftMask, xK_Down  ), shiftToNext     )
    , ((modm .|. shiftMask, xK_Up    ), shiftToPrev     )
    , ((modm,               xK_Right ), nextScreen      )
    , ((modm,               xK_Left  ), prevScreen      )
    , ((modm .|. shiftMask, xK_Right ), shiftNextScreen )
    , ((modm .|. shiftMask, xK_Left  ), shiftPrevScreen )
    , ((modm .|. shiftMask, xK_period), toggleWS        )

    , ((modm, xK_g), goToSelected myGSConf)
    , ((modm, xK_b), bringSelected myGSConf)

    , ((modm,               xK_d), withFocused hideWindow)
    , ((modm .|. shiftMask, xK_d), popOldestHiddenWindow)

    , ((modm, xK_period), gridselectWorkspace myGSConfWs W.view)

    , ((modm, xK_semicolon), runSelectedAction myGSConfS
        [ ("Tab"     , sendMessage $ JumpToLayout "Tab"     )
        , ("Tiled"   , sendMessage $ JumpToLayout "Tiled"   )
        , ("Column"  , sendMessage $ JumpToLayout "Column"  )
        , ("Grid"    , sendMessage $ JumpToLayout "Grid"    )
        , ("Full"    , sendMessage $ JumpToLayout "Full"    )
        , ("MTiled"  , sendMessage $ JumpToLayout "MTiled"  )
        , ("MColumn" , sendMessage $ JumpToLayout "MColumn" )
        ]
      )
    , ((modm, xK_y), pasteSelection)

    , ((modm, xK_o), windowMenu)
    ]

myLayout = beforeLayouts layouts
  where
    layouts =
            renamed [ Replace "Tab" ] (noBorders $ tabbed shrinkText def
                { inactiveBorderColor = solarizedBase01
                , activeBorderColor   = solarizedBase01
                , inactiveTextColor   = solarizedBase01
                , activeTextColor     = solarizedBase03
                , inactiveColor       = solarizedBase02
                , activeColor         = solarizedYellow
                , fontName            = myFontCJKSmall
                , decoHeight          = 20
                })
        ||| renamed [ Replace "Tiled"     ] tiled
        ||| renamed [ Replace "Grid"      ] Grid
        ||| renamed [ Replace "MTiled"    ] (Mirror tiled)
        ||| renamed [ Replace "Column"    ] column
        ||| renamed [ Replace "MColumn"   ] (Mirror column)
        ||| renamed [ Replace "Full"      ] Full
    tiled = Tall 1 (3/100) (1/2)
    column = Column 1
    beforeLayouts = showWName . hiddenWindows

myWorkspaces = [ "home"
               , "web"
               , "doc"
               , "taichi"
               , "misc"
               , "bg"
               , "vbox"
               , "magic"
               , "play"
               ]

myDef = def
    { modMask            = myModMask
    , terminal           = myTerm
    , keys               = keys def <+> myKeys
    , layoutHook         = myLayout
    , focusFollowsMouse  = True
    , focusedBorderColor = solarizedCyan
    , normalBorderColor  = solarizedViolet
    , borderWidth        = 1
    , workspaces         = myWorkspaces
    }

solarizedBase03  = "#002b36"
solarizedBase02  = "#073642"
solarizedBase01  = "#586e75"
solarizedBase00  = "#657b83"
solarizedBase0   = "#839496"
solarizedBase1   = "#93a1a1"
solarizedBase2   = "#eee8d5"
solarizedBase3   = "#fdf6e3"
solarizedYellow  = "#b58900"
solarizedOrange  = "#cb4b16"
solarizedRed     = "#dc322f"
solarizedMagenta = "#d33682"
solarizedViolet  = "#6c71c4"
solarizedBlue    = "#268bd2"
solarizedCyan    = "#2aa198"
solarizedGreen   = "#859900"

main = xmonad myDef
