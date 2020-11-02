{-# LANGUAGE LambdaCase #-}

import XMonad hiding ((|||))
import XMonad.Util.EZConfig
import XMonad.Actions.Navigation2D
import XMonad.Actions.Search
import XMonad.Actions.DynamicWorkspaces
import XMonad.Layout.WorkspaceDir
import XMonad.Actions.CycleWS
import XMonad.Actions.CycleSelectedLayouts
import XMonad.Actions.GroupNavigation
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Layout.ShowWName
import XMonad.Layout.GridVariants hiding (Orientation(..))
import qualified XMonad.Layout.GridVariants as GridVariants
import XMonad.Layout.Column
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.DragPane
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.CenteredMaster
import XMonad.Layout.Renamed
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.StackSet hiding (float, workspaces, allWindows)

import Data.Ratio
import System.IO
import System.Exit

-- auxiliary configuration
myFont = "xft:Sarasa Mono SC:size=11"
myModMask = mod4Mask
myTerm = "alacritty"

myXPConf = def
    { font            = myFont
    , searchPredicate = fuzzyMatch
    , sorter          = fuzzySort
    , bgColor         = draculaBackground
    , fgColor         = draculaForeground
    , bgHLight        = draculaSelection
    , fgHLight        = draculaForeground
    , borderColor     = draculaPurple
    , autoComplete    = Just $ 2 * 10 ^ 5 -- use this to avoid pass unwill
                                          -- key to applications
    , height          = 30
    }

myXPConfNoAc = myXPConf { autoComplete = Nothing }

mySWNConf = def { swn_font    = myFont
                , swn_bgcolor = draculaBackground
                , swn_color   = draculaForeground
                , swn_fade    = 1 % 1
                }

-- my configurations

myKeys conf = mkKeymap conf
    [ ("M-x"  , shellPrompt myXPConf           )
    , ("M-S-x", shellPrompt myXPConfNoAc       )
    , ("M-C-x", xmonadPrompt myXPConf          )
    , ("M-/"  , promptSearch myXPConfNoAc multi)

    , ("M-<F1>"  , manPrompt myXPConf             )
    , ("M-S-<F1>", runInTerm "-t w3mman" "w3mman" )

    , ("M-, d", spawn "zeal"            )
    , ("M-, b", spawn "qutebrowser"     )
    , ("M-, o", spawn "libreoffice"     )
    , ("M-, v", spawn "VirtualBox"      )
    , ("M-, f", spawn "zathura"         )
    , ("M-, t", spawn "telegram-desktop")
    , ("M-, p", spawn "1password"       )
    , ("M-, j", spawn "pulseeffects"    )
    , ("M-, k", spawn "pavucontrol"     )
    , ("M-, m", spawn "audacious"       )
    , ("M-, #", runInTerm "-t cmatrix" "cmatrix")
    , ("M-, a", runInTerm "-t htop"    "htop"   )

    , ("M-# r", spawn "systemctl reboot"   )
    , ("M-# s", spawn "systemctl suspend"  )
    , ("M-# h", spawn "systemctl hibernate")
    , ("M-# o", spawn "systemctl poweroff" )

    , ("M-c c", spawn "dunstctl close"      )
    , ("M-c a", spawn "dunstctl close-all"  )
    , ("M-c p", spawn "dunstctl history-pop")

    , ("M-$"  , runInTerm "" "watch date"     )
    , ("M-'"  , runInTerm "-t ranger" "ranger")
    , ("M-S-'", spawn "emacsclient -c"  )

    -- basic window
    , ("M-S-<Return>", spawn $ XMonad.terminal conf      )
    , ("M-S-c"       , kill                              )
    , ("M-S-<Space>" , setLayout $ XMonad.layoutHook conf)
    , ("M-C-<Space>" , sendMessage NextLayout            )
    , ("M-n"         , refresh                           )

    -- move focus up or down the window stack
    , ("M-<Tab>"   , windows focusDown  )
    , ("M-S-<Tab>" , windows focusUp    )
    , ("M-m"       , windows focusMaster)
    , ("M-<Return>", windows swapMaster )

    -- resizing the master/slave ratio
    , ("M-(", sendMessage Shrink)
    , ("M-)", sendMessage Expand)

    -- floating layer support
    , ("M-t"  , withFocused $ windows . sink)
    , ("M-S-t", withFocused float           )

    -- increase or decrease number of windows in the master area
    , ("M-[", sendMessage (IncMasterN (-1)))
    , ("M-]", sendMessage (IncMasterN 1   ))

    -- quit, or restart
    , ("M-S-q", io (exitWith ExitSuccess))
    , ("M-q"  , spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")

    -- screenshot
    , ("M-a"  , spawn "flameshot gui    -p ~/Pictures/screenshot/" )
    , ("M-S-a", spawn "flameshot screen -p ~/Pictures/screenshot/" )
    , ("M-C-a", spawn "flameshot full   -p ~/Pictures/screenshot/"  )

    -- Switch between layers
    , ("M-<Space>", cycleThroughLayouts [ "Full", "Centered" ])

    -- switch window
    , ("M-.", windowMultiPrompt myXPConf $
        (\d -> (d, allWindows)) <$> [ Goto
                                    , Bring
                                    , BringToMaster
                                    , BringCopy
                                    ])
    , ("M-S-.", windowMultiPrompt myXPConf $
        (\d -> (d, wsWindows)) <$> [ Goto
                                   , Bring
                                   , BringToMaster
                                   , BringCopy
                                   ])

    -- window navigation
    , ("M-C-.", nextMatch History (return True))

    -- layout select
    , ("M-; d" , sendMessage $ JumpToLayout "DragV"   )
    , ("M-; g" , sendMessage $ JumpToLayout "Grid"    )
    , ("M-; v" , sendMessage $ JumpToLayout "GridL"   )
    , ("M-; c" , sendMessage $ JumpToLayout "Column"  )
    , ("M-; t" , sendMessage $ JumpToLayout "Tiled"   )
    , ("M-S-; t" , sendMessage $ JumpToLayout "MTiled"  )
    , ("M-S-; c" , sendMessage $ JumpToLayout "MColumn" )
    , ("M-S-; d" , sendMessage $ JumpToLayout "DragH"   )

    -- Directional navigation of windows
    , ("M-l", windowGo R False)
    , ("M-h", windowGo L False)
    , ("M-k", windowGo U False)
    , ("M-j", windowGo D False)

    -- Swap adjacent windows
    , ("M-S-l", windowSwap R False)
    , ("M-S-h", windowSwap L False)
    , ("M-S-k", windowSwap U False)
    , ("M-S-j", windowSwap D False)

    -- Directional navigation of screens
    , ("M-<Right>", screenGo R False)
    , ("M-<Left>" , screenGo L False)
    , ("M-<Up>"   , screenGo U False)
    , ("M-<Down>" , screenGo D False)

    -- Swap workspaces on adjacent screens
    , ("M-S-<Right>", screenSwap R False)
    , ("M-S-<Left>" , screenSwap L False)
    , ("M-S-<Up>"   , screenSwap U False)
    , ("M-S-<Down>" , screenSwap D False)

    -- Send window to adjacent screen
    , ("M-C-<Right>", windowToScreen R False)
    , ("M-C-<Left>" , windowToScreen L False)
    , ("M-C-<Up>"   , windowToScreen U False)
    , ("M-C-<Down>" , windowToScreen D False)

    -- cycle workspace
    , ("M-}"   , nextWS      )
    , ("M-{"   , prevWS      )
    , ("M-S-}" , shiftToNext )
    , ("M-S-{" , shiftToPrev )
    , ("M-C-g" , toggleWS    )

    -- dynamic workspace
    , ("M-g"  , workspacePrompt myXPConf (windows . view ))
    , ("M-S-g", workspacePrompt myXPConf (windows . shift))
    , ("M-w d", removeWorkspace)
    , ("M-w n", addWorkspacePrompt myXPConf)
    , ("M-w r", renameWorkspace myXPConf)

    -- change pwd for current workspace
    , ("M-p", changeDir myXPConfNoAc)

    -- hide windows
    , ("M-d"  , withFocused hideWindow)
    , ("M-S-d", popNewestHiddenWindow)
    , ("M-C-d", popOldestHiddenWindow)

    -- fcitx clipboard history to paste

    -- midia keys
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 1%-" )
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 1%+" )
    , ("<XF86AudioMute>"       , spawn "pactl set-sink-mute 0 toggle")
    ]

myLayout = beforeLayouts layouts
  where
    layouts =
            renamed [ Replace "Tiled"     ] tiled
        ||| renamed [ Replace "GridL"     ] (SplitGrid GridVariants.L 2 3 (2/3) (16/10) (1/100))
        ||| renamed [ Replace "DragV"     ] (dragPane Vertical 0.1 0.5 )
        ||| renamed [ Replace "Grid"      ] (Grid $ 16 / 10)
        ||| renamed [ Replace "DragH"     ] (dragPane Horizontal 0.1 0.5 )
        ||| renamed [ Replace "MTiled"    ] (Mirror tiled)
        ||| renamed [ Replace "Column"    ] column
        ||| renamed [ Replace "MColumn"   ] (Mirror column)
        ||| renamed [ Replace "Full"      ] (noBorders Full)
        ||| renamed [ Replace "Centered"  ] (centerMaster $ Grid $ 16 / 10)
    tiled = Tall 1 (3/100) (1/2)
    column = Column 1
    beforeLayouts = showWName' mySWNConf . hiddenWindows . workspaceDir "~"

myWorkspaces = [ "home"
               , "doc"
               , "web"
               , "taichi"
               , "misc"
               , "bg"
               , "vbox"
               , "magic"
               , "play"
               ]

myStartup = spawnOnOnce "home" "emacs"

myLoghook = historyHook

myDef = def
    { modMask            = myModMask
    , terminal           = myTerm
    , keys               = myKeys
    , startupHook        = myStartup
    , layoutHook         = myLayout
    , focusFollowsMouse  = True
    , focusedBorderColor = draculaPurple
    , normalBorderColor  = draculaComment
    , borderWidth        = 1
    , workspaces         = myWorkspaces
    , logHook            = myLoghook
    }

-- main
main = xmonad $ withNavigation2DConfig def $ myDef

draculaBackground = "#282a36"
draculaForeground = "#f8f8f2"
draculaComment    = "#6272a4"
draculaSelection  = "#44475a"
draculaCurrent    = "#44475a"
draculaYellow     = "#f1fabc"
draculaOrange     = "#ffb86c"
draculaRed        = "#ff5555"
draculaPink       = "#ff79c6"
draculaPurple     = "#bd93f9"
draculaCyan       = "#8be9fd"
draculaGreen      = "#50fa7b"