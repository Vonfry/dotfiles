{-# LANGUAGE LambdaCase #-}

import XMonad hiding ((|||))
import XMonad.Util.EZConfig
import XMonad.Actions.Navigation2D
import XMonad.Actions.Search
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CycleWS
import XMonad.Actions.CycleSelectedLayouts
import XMonad.Actions.GroupNavigation
import XMonad.Actions.UpdatePointer
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Pass
import XMonad.Prompt.Man
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.NoBorders
import XMonad.Layout.Hidden
import XMonad.Layout.MagicFocus
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.GridVariants hiding (Orientation(..))
import qualified XMonad.Layout.GridVariants as GridVariants
import XMonad.Layout.Column
import XMonad.Layout.DragPane
import XMonad.Layout.CenteredMaster
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
    , bgHLight        = draculaYellow
    , fgHLight        = draculaSelection
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
    , ("M-, v", spawn "virt-manager"    )
    , ("M-, f", spawn "zathura"         )
    , ("M-, t", spawn "telegram-desktop")
    , ("M-, j", spawn "pulseeffects"    )
    , ("M-, k", spawn "pavucontrol"     )
    , ("M-, m", spawn "audacious"       )
    , ("M-, '", runInTerm "-t cmatrix" "cmatrix")
    , ("M-, a", runInTerm "-t htop"    "htop"   )

    , ("M-s r", spawn "systemctl reboot"   )
    , ("M-s s", spawn "systemctl suspend"  )
    , ("M-s h", spawn "systemctl hibernate")
    , ("M-s o", spawn "systemctl poweroff" )

    , ("M-n c", spawn "dunstctl close"      )
    , ("M-n a", spawn "dunstctl close-all"  )
    , ("M-n p", spawn "dunstctl history-pop")

    , ("M-$"  , runInTerm "" "watch date"     )

    -- basic window
    , ("M-<Return>"  , spawn $ terminal conf             )
    , ("M-S-<Return>", runInTerm "-t ranger" "ranger"    )
    , ("M-C-<Return>", spawn "emacsclient -c"            )
    , ("M-S-c"       , kill                              )
    , ("M-C-<Space>" , setLayout $ layoutHook conf       )
    , ("M-S-<Space>" , sendMessage NextLayout            )
    , ("M-r"         , refresh                           )

    -- move focus up or down the window stack
    , ("M-<Tab>"    , windows focusDown  )
    , ("M-S-<Tab>"  , windows focusUp    )
    , ("M-C-<Tab>"  , windows swapDown   )
    , ("M-C-S-<Tab>", windows swapUp     )
    , ("M-S-m"      , windows focusMaster)
    , ("M-m"        , windows swapMaster )

    -- resizing the master/slave ratio
    , ("M-("  , sendMessage Expand)
    , ("M-S-(", sendMessage Shrink)

    -- floating layer support
    , ("M-t"  , withFocused $ windows . sink)
    , ("M-S-t", withFocused float           )

    -- increase or decrease number of windows in the master area
    , ("M-)"  , sendMessage (IncMasterN 1   ))
    , ("M-S-)", sendMessage (IncMasterN (-1)))

    -- quit, or restart
    , ("M-S-q", io (exitWith ExitSuccess))
    , ("M-q"  , spawn "xmonad --recompile && xmonad --restart")

    -- screenshot
    , ("M-a"  , spawn "flameshot gui    -p ~/Pictures/screenshot/" )
    , ("M-S-a", spawn "flameshot screen -p ~/Pictures/screenshot/" )
    , ("M-C-a", spawn "flameshot full   -p ~/Pictures/screenshot/" )

    -- Switch between layers
    , ("M-<Space>", cycleThroughLayouts [ "Full", "Preview" ])

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
    , ("M-; d" , sendMessage $ JumpToLayout "DragV" )
    , ("M-; g" , sendMessage $ JumpToLayout "Grid"  )
    , ("M-; v" , sendMessage $ JumpToLayout "GridL" )
    , ("M-; c" , sendMessage $ JumpToLayout "Column")
    , ("M-; t" , sendMessage $ JumpToLayout "Tiled" )
    , ("M-S-; t" , sendMessage $ JumpToLayout "MTiled" )
    , ("M-S-; c" , sendMessage $ JumpToLayout "MColumn")
    , ("M-S-; d" , sendMessage $ JumpToLayout "DragH"  )

    -- Directional navigation of windows
    -- keybind for dvorak like vim but different
    , ("M-e", windowGo L True)
    , ("M-j", windowGo D True)
    , ("M-k", windowGo U True)
    , ("M-u", windowGo R True)

    -- Swap adjacent windows
    -- keybind for dvorak like vim but different
    , ("M-S-e", windowSwap L True)
    , ("M-S-j", windowSwap D True)
    , ("M-S-k", windowSwap U True)
    , ("M-S-u", windowSwap R True)

    -- Directional navigation of screens
    , ("M-<Left>" , screenGo L True)
    , ("M-<Up>"   , screenGo U True)
    , ("M-<Down>" , screenGo D True)
    , ("M-<Right>", screenGo R True)

    -- Swap workspaces on adjacent screens
    , ("M-S-<Left>" , screenSwap L True)
    , ("M-S-<Down>" , screenSwap D True)
    , ("M-S-<Up>"   , screenSwap U True)
    , ("M-S-<Right>", screenSwap R True)

    -- Send window to adjacent screen
    , ("M-C-<Left>" , windowToScreen L True)
    , ("M-C-<Down>" , windowToScreen D True)
    , ("M-C-<Up>"   , windowToScreen U True)
    , ("M-C-<Right>", windowToScreen R True)

    -- cycle workspace
    , ("M-}"   , nextWS      )
    , ("M-{"   , prevWS      )
    , ("M-S-}" , shiftToNext )
    , ("M-S-{" , shiftToPrev )
    , ("M-C-g" , toggleWS    )

    -- dynamic workspace
    , ("M-g"  , workspacePrompt myXPConf (windows . view ))
    , ("M-S-g", workspacePrompt myXPConf (windows . shift))
    , ("M-w d", removeWorkspace            )
    , ("M-w n", addWorkspacePrompt myXPConf)
    , ("M-w r", renameWorkspace myXPConf   )

    -- change pwd for current workspace
    , ("M-c", changeDir myXPConfNoAc)

    -- hide windows
    , ("M-d"  , withFocused hideWindow)
    , ("M-S-d", popNewestHiddenWindow )
    , ("M-C-d", popOldestHiddenWindow )

    -- fcitx clipboard history to paste

    -- password-store
    , ("M-'"  , passPrompt         myXPConf    )
    , ("M-S-'", passGeneratePrompt myXPConfNoAc)
    , ("M-C-'", passRemovePrompt   myXPConf    )

    -- midia keys
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 1%-" )
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 1%+" )
    , ("<XF86AudioMute>"       , spawn "pactl set-sink-mute 0 toggle")
    ]

myLayout = beforeLayouts layouts
  where
    gridRatio = 16 / 10

    layouts = renamed [ Replace "Tiled"     ] tiled
          ||| renamed [ Replace "GridL"     ] splitGrid
          ||| renamed [ Replace "DragV"     ] (drag Vertical  )
          ||| renamed [ Replace "Grid"      ] grid
          ||| renamed [ Replace "DragH"     ] (drag Horizontal)
          ||| renamed [ Replace "MTiled"    ] (Mirror tiled   )
          ||| renamed [ Replace "Column"    ] column
          ||| renamed [ Replace "MColumn"   ] (Mirror column  )
          ||| renamed [ Replace "Full"      ] Full
          ||| renamed [ Replace "Preview"   ] preview
    splitGrid = SplitGrid GridVariants.L 2 3 (2/3) gridRatio (1/100)
    grid      = Grid gridRatio
    tiled     = Tall 1 (3/100) (1/2)
    drag d    = dragPane d 0.1 0.5
    column    = Column 1
    preview   = magicFocus $ centerMaster grid

    cleanupNames  = renamed [ CutWordsLeft 1 ]
    beforeLayouts = cleanupNames
                  . showWName' mySWNConf
                  . smartBorders
                  . hiddenWindows
                  . workspaceDir "~"

myWorkspaces = [ "home"
               , "doc"
               , "web"
               , "taichi"
               , "misc"
               , "bg"
               , "vm"
               , "magic"
               , "play"
               ]

myStartup = spawnOnOnce "home" "emacs"

myLoghook = historyHook
         <> updatePointer (0.5, 0.5) (0, 0)

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
