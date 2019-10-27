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

myFont = "xft:Hack:size=8"
myFontCJK = "xft:Source Han Sans CN:size=8"
myModMask = mod4Mask
myTerm = "alacritty"

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
    , ((modm .|. shiftMask, xK_x), runSelectedAction myGSConfS
        [ ("zeal"       , spawn "zeal"                                          )
        , ("freenode"   , spawn "alacritty -e weechat -r \"/connect freenode\"" )
        , ("mutt"       , spawn "alacritty -e mutt"                             )
        , ("chromium"   , spawn "chromium"                                      )
        , ("virtualbox" , spawn "VirtualBox"                                    )
        , ("pcloud"     , spawn "appimage-run $APPIMAGE_APP_DIR/pcloud"         )
        , ("telegram"   , spawn "telegram-desktop"                              )
        ]
      )
    , ((modm, xK_apostrophe), xmonadPrompt myXPConf      )
    , ((modm, xK_slash     ), promptSearch myXPConf multi)

    , ((modm, xK_F1), manPrompt myXPConf)

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
    , ((modm .|. shiftMask, xK_z     ), toggleWS        )

    , ((modm, xK_g), goToSelected myGSConf)
    , ((modm, xK_b), bringSelected myGSConf)

    , ((modm,               xK_d), withFocused hideWindow)
    , ((modm .|. shiftMask, xK_d), popOldestHiddenWindow)

    , ((modm, xK_z), gridselectWorkspace myGSConfWs W.view)

    , ((modm, xK_semicolon), runSelectedAction myGSConfS
        [ ("Tab"   , sendMessage $ JumpToLayout "Tab"   )
        , ("Tiled" , sendMessage $ JumpToLayout "Tiled" )
        , ("MTiled", sendMessage $ JumpToLayout "MTiled")
        , ("Grid"  , sendMessage $ JumpToLayout "Grid"  )
        , ("Full"  , sendMessage $ JumpToLayout "Full"  )
        ]
      )
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
        ||| renamed [ Replace "Grid"      ] Grid
        ||| renamed [ Replace "Tiled"     ] tiled
        ||| renamed [ Replace "MTiled"    ] (Mirror tiled)
        ||| renamed [ Replace "Column"    ] column
        ||| renamed [ Replace "MColumn"   ] (Mirror column)
        ||| renamed [ Replace "Full"      ] Full
    tiled = Tall 1 (3/100) (1/2)
    column = Column 1
    beforeLayouts = showWName . hiddenWindows

myDef = def
    { modMask            = myModMask
    , terminal           = myTerm
    , keys               = myKeys <+> keys def
    , layoutHook         = myLayout
    , focusFollowsMouse  = False
    , focusedBorderColor = "#268bd2" -- solarized blue
    , normalBorderColor  = "#073642" -- solarized base03
    }

main = xmonad myDef
