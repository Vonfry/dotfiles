import XMonad hiding ((|||))
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
import XMonad.Actions.GridSelect
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
    [ ("zeal"      , "zeal"                  )
    , ("browser"   , "firefox"               )
    , ("voice"     , myCLI "alsamixer"       )
    , ("document"  , "libreoffice"           )
    , ("virtualbox", "VirtualBox"            )
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
    , ((modm              , xK_comma), runSelectedAction myGSConfS $ fmap (\(name, cmd) -> (name, spawn cmd)) myApps)
    , ((modm .|. shiftMask, xK_comma), mkXPrompt MyApps myXPConf
                                                        (mkComplFunFromList $ fst $ unzip myApps)
                                                        ((\case Just cmd -> spawn cmd
                                                                Nothing  -> return ()) . flip lookup $ myApps )) -- TODO test
    , ((modm, xK_dollar), runSelectedAction myGSConfS
        [ ("poweroff"    , spawn "poweroff"         )
        , ("suspend"     , spawn "systemctl suspend")
        , ("reboot"      , spawn "reboot"           )
        , ("halt"        , spawn "halt"             )
        ]
      )
    , ((modm .|. shiftMask, xK_x), xmonadPrompt myXPConf)
    , ((modm, xK_slash), promptSearch myXPConf multi)

    -- file and editor
    , ((modm              , xK_f), spawn $ myCLI "ranger")
    , ((modm .|. shiftMask, xK_f), spawn "emacs"         )

    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modm .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    , ((modm,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modm,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modm,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modm,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modm,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modm,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modm,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modm,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modm,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modm,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modm              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    , ((modm .|. shiftMask, xK_slash ), helpCommand) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
    -- repeat the binding for non-American layout keyboards
    , ((modm              , xK_question), spawn ("echo " ++ show help ++ " | xmessage -file -"))

    , ((modm                , xK_Print), spawn "flameshot gui    -p ~/screenshot/" )
    , ((modm .|. controlMask, xK_Print), spawn "flameshot screen -p  ~/screenshot/")
    , ((modm .|. shiftMask  , xK_Print), spawn "flameshot full   -p ~/screenshot"  )

    , ((modm .|. shiftMask, xK_t), withFocused float)

    -- cycle workspace
    , ((modm,               xK_Down  ), nextWS          )
    , ((modm,               xK_Up    ), prevWS          )
    , ((modm .|. shiftMask, xK_Down  ), shiftToNext     )
    , ((modm .|. shiftMask, xK_Up    ), shiftToPrev     )
    , ((modm,               xK_Right ), nextScreen      )
    , ((modm,               xK_Left  ), prevScreen      )
    , ((modm .|. shiftMask, xK_Right ), shiftNextScreen )
    , ((modm .|. shiftMask, xK_Left  ), shiftPrevScreen )
    , ((modm .|. shiftMask, xK_period), toggleWS        )
    , ((modm, xK_period), gridselectWorkspace myGSConfWs W.view)

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
