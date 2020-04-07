import XMonad hiding ((|||))
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
import XMonad.Actions.GridSelect -- TODO remove this if prompt work fine
import XMonad.Layout.WorkspaceDir
import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Layout
import XMonad.Prompt.Window
import XMonad.Prompt.FuzzyMatch
import XMonad.Layout.ShowWName
import XMonad.Layout.GridVariants
import XMonad.Layout.Column
import XMonad.Layout.Tabbed
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.DragPane
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Renamed
import XMonad.Util.Paste
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified  Data.Map as M
import System.IO

-- auxiliary configuration
myFont = "xft:Hack:size=9"
myFontCJK = "xft:Source Han Sans CN:size=11"
myFontCJKSmall = "xft:Source Han Sans CN:size=9"
myModMask = mod4Mask
myTerm = "alacritty"

myCLI args = myTerm ++ " -e " ++ args

myXPConf = def
    { font            = myFont
    , searchPredicate = fuzzyMatch
    , sorter          = fuzzySort
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

myApps =
    [ ("doc"       , "zeal"                  )
    , ("gbrowser"  , "firefox"               )
    , ("tbrowser"  , myCLI "w3m"             )
    , ("voice"     , myCLI "alsamixer"       )
    , ("office"    , "libreoffice"           )
    , ("vm"        , "VirtualBox"            )
    , ("viewer"    , "zathura"               )
    , ("telegram"  , "telegram-desktop"      )
    , ("video"     , "vlc"                   )
    ]

data MyApps = MyApps

instance XPrompt MyApps where
  showXPrompt MyApps = "App: "

-- my configurations

{-# LANGUAGE LambdaCase #-}

myKeys conf@(XConfig {modMask = modm}) = M.fromList
    [ ((modm              , xK_x    ), shellPrompt myXPConf)
    , ((modm .|. shiftMask, xK_x    ), xmonadPrompt myXPConf)
    , ((modm              , xK_slash), promptSearch myXPConf multi)
    , ((modm              , xK_comma), runSelectedAction myGSConfS $ fmap (\(name, cmd) -> (name, spawn cmd)) myApps)
    , ((modm .|. shiftMask, xK_comma), mkXPrompt MyApps myXPConf
                                                        (mkComplFunFromList $ fst $ unzip myApps)
                                                        ((\case Just cmd -> spawn cmd
                                                                Nothing  -> return ()) . flip lookup $ myApps)) -- TODO test

    -- basic window
    , ((modm              , xK_apostrophe), spawn $ myCLI "ranger")
    , ((modm .|. shiftMask, xK_apostrophe), spawn "emacs"         )
    , ((modm .|. shiftMask, xK_Return    ), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_c         ), kill)
    , ((modm .|. shiftMask, xK_space     ), setLayout $ XMonad.layoutHook conf)
    , ((modm              , xK_n         ), refresh)

    -- move focus up or down the window stack
    , ((modm              , xK_Tab   ), windows W.focusDown  )
    , ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp    )
    , ((modm              , xK_m     ), windows W.focusMaster)
    , ((modm              , xK_Return), windows W.swapMaster )

    -- resizing the master/slave ratio
    , ((modm, xK_bracketleft ), sendMessage Shrink)
    , ((modm, xK_bracketright), sendMessage Expand)

    -- floating layer support
    , ((modm              , xK_t), withFocused $ windows . W.sink)
    , ((modm .|. shiftMask, xK_t), withFocused float)

    -- increase or decrease number of windows in the master area
    , ((modm, xK_parenleft ), sendMessage (IncMasterN 1))
    , ((modm, xK_parenright), sendMessage (IncMasterN (

    -- quit, or restart
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))
    , ((modm              , xK_q), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")

    -- help
    , ((modm .|. shiftMask, xK_slash), helpCommand)

    -- screenshot
    , ((modm                , xK_Print), spawn "flameshot gui    -p ~/screenshot/" )
    , ((modm .|. controlMask, xK_Print), spawn "flameshot screen -p  ~/screenshot/")
    , ((modm .|. shiftMask  , xK_Print), spawn "flameshot full   -p ~/screenshot"  )

    -- Switch between layers
    , ((modm                , xK_space), switchLayer)

    -- Directional navigation of windows
    , ((modm                , xK_l    ), windowGo R False)
    , ((modm                , xK_h    ), windowGo L False)
    , ((modm                , xK_j    ), windowGo U False)
    , ((modm                , xK_k    ), windowGo D False)

    -- Swap adjacent windows
    , ((modm .|. shiftMask  , xK_l    ), windowSwap R False)
    , ((modm .|. shiftMask  , xK_h    ), windowSwap L False)
    , ((modm .|. shiftMask  , xK_j    ), windowSwap U False)
    , ((modm .|. shiftMask  , xK_k    ), windowSwap D False)

    -- Directional navigation of screens
    , ((modm                , xK_Right), screenGo R False)
    , ((modm                , xK_Left ), screenGo L False)
    , ((modm                , xK_Up   ), screenGo U False)
    , ((modm                , xK_Down ), screenGo D False)

    -- Swap workspaces on adjacent screens
    , ((modm .|. shiftMask  , xK_Right), screenSwap R False)
    , ((modm .|. shiftMask  , xK_Left ), screenSwap L False)
    , ((modm .|. shiftMask  , xK_Up   ), screenSwap U False)
    , ((modm .|. shiftMask  , xK_Down ), screenSwap D False)

    -- Send window to adjacent screen
    , ((modm .|. controlMask, xK_Right), windowToScreen R False)
    , ((modm .|. controlMask, xK_Left ), windowToScreen L False)
    , ((modm .|. controlMask, xK_Up   ), windowToScreen U False)
    , ((modm .|. controlMask, xK_Down ), windowToScreen D False)

    -- cycle workspace
    , ((modm                , xK_bracerigh ), nextWS                               )
    , ((modm                , xK_braceleft ), prevWS                               )
    , ((modm .|. shiftMask  , xK_braceright), shiftToNext                          )
    , ((modm .|. shiftMask  , xK_braceleft ), shiftToPrev                          )
    , ((modm .|. shiftMask  , xK_period    ), toggleWS                             )
    , ((modm                , xK_period    ), gridselectWorkspace myGSConfWs W.view)
    , ((modm .|. controlMask, xK_period    ), workspacePrompt def (windows . W.shift))

    -- change pwd for current workspace
    , ((modm, xK_p), changeDir myXPConf)

    , ((modm                , xK_g), goToSelected  myGSConf)
    , ((modm .|. shiftMask  , xK_g), bringSelected myGSConf)
    , ((modm .|. controlMask, xK_g), mkXPromptWithModes [Goto, Bring, BringToMaster, BringCopy]) myXPConf -- TODO test

    -- hide windows
    , ((modm,               xK_d), withFocused hideWindow)
    , ((modm .|. shiftMask, xK_d), popOldestHiddenWindow)

    -- layout select
    , ((modm .|. shiftMask, xK_semicolon), layoutPrompt myXPConf) -- TODO test
    , ((modm, xK_semicolon), runSelectedAction myGSConfS
        [ ("Tab"     , sendMessage $ JumpToLayout "Tab"     )
        , ("Tiled"   , sendMessage $ JumpToLayout "Tiled"   )
        , ("GridL"   , sendMessage $ JumpToLayout "GridL"   )
        , ("DrapV"   , sendMessage $ JumpToLayout "DrapV"   )
        , ("Column"  , sendMessage $ JumpToLayout "Column"  )
        , ("Grid"    , sendMessage $ JumpToLayout "Grid"    )
        , ("Full"    , sendMessage $ JumpToLayout "Full"    )
        , ("DrapH"   , sendMessage $ JumpToLayout "DrapH"   )
        , ("MTiled"  , sendMessage $ JumpToLayout "MTiled"  )
        , ("MColumn" , sendMessage $ JumpToLayout "MColumn" )
        ]
      )

    -- paste
    , ((modm, xK_y), pasteSelection)

    -- window menu
    , ((modm, xK_z), windowMenu)
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
        ||| renamed [ Replace "GridL"     ] (SplitGrid L 2 3 (2/3) (16/10) (1/100))
        ||| rename  [ Replace "DragV"     ] (dragPane Vectial -2.1 0.5 )
        ||| renamed [ Replace "Grid"      ] (Grid (16/10))
        ||| rename  [ Replace "DragH"     ] (dragPane Horizontal 0.1 0.5 )
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
    , keys               = myKeys
    , layoutHook         = myLayout
    , focusFollowsMouse  = True
    , focusedBorderColor = solarizedCyan
    , normalBorderColor  = solarizedViolet
    , borderWidth        = 1
    , workspaces         = myWorkspaces
    }

-- main
main = xmonad myDef

-- color define
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
