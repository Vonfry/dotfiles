{-# LANGUAGE LambdaCase #-}

import XMonad ( xmonad, refersh, io
              , def, windows , withFocused

              , layoutHook, setLayout
              , Tall(Tall), Full(Full), Mirror(Mirror)

              , kill, float

              , mod4Mask

              , sendMessage, ChangeLayout(NextLayout), ReSize(..)
              , IncMasterN(IncMasterN)
              )
import XMonad.Prompt.XMonad (xmonadPrompt)
import XMonad.StackSet ( focusDown, focusUp, focusMaster
                       , swapMaster, swapDown, swapUp
                       , sink, shift, view
                       )
import XMonad.Actions.Navigation2D ( winodwGo, windowSwap, screenGo, screenSwap
                                   , windowToScreen
                                   , Direction2D(..)
                                   )
import XMonad.Prompt.Window ( windowMultiPrompt, allWindows, wsWindows
                            , WindowPrompt(..)
                            )
import XMonad.Actions.UpdatePointer (updatePointer)

import XMonad.Actions.CycleWS ( nextWS, prevWS, shiftToNext, shiftToPrev
                              , toggleWS
                              )
import XMonad.Prompt.Workspace (workspacePrompt)
import XMonad.Actions.SwapWorkspaces (swapWithCurrent, Direction1D(..), swapTo)
import XMonad.Actions.DynamicWorkspaces ( addWorkspacePrompt, removeWorkspace
                                        , renameWorkspace
                                        )
import XMonad.Layout.WorkspaceDir (changeDir)
import XMonad.Actions.GroupNavigation ( nextMatch, Direction(History)
                                      , historyHook
                                      )

import XMonad.Prompt ()
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.FuzzyMatch (fuzzyMatch, fuzzySort)
import XMonad.Prompt.Pass (passPrompt, passOTPPrompt)
import XMonad.Prompt.Man (manPrompt)
import XMonad.Prompt.Ssh (sshPrompt)
import XMonad.Actions.Search (promptSearch, multi)

import XMonad.Layout.LayoutCombinators ( (|||), JumpToLayout(JumpToLayout)
                                       , withNavigation2DConfig
                                       )
import XMonad.Actions.CycleSelectedLayouts (cycleThroughLayouts)
import XMonad.Layout.Renamed (renamed, Rename(..))
import XMonad.Layout.ShowWName (showWName')
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Minimize (minmize)
import XMonad.Actions.Minimize ( minimizeWindow, maximizeWindow
                               , withFirstMinimized, withLastMinimized
                               , withMinimized
                               )
import XMonad.Layout.GridVariants (SplitGrid, Grid)
import qualified XMonad.Layout.GridVariants as GridVariants
import XMonad.Layout.Column (Column(Column))
import XMonad.Layout.DragPane (dragPane, DragType(..))
import XMonad.Layout.CenteredMaster (centerMaster)
import XMonad.Layout.MagicFocus (magicFocus)

import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Util.Run (spawn, runInTerm)

import Data.Ratio ((%))
import System.Exit (exitWith, ExitCode(ExitSuccess))

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
    , ("M-z"  , sshPrompt myXPConf             )

    , ("M-<F1>"  , manPrompt myXPConf   )

    , ("M-o d", spawn "zeal"            )
    , ("M-o b", spawn "qutebrowser"     )
    , ("M-o o", spawn "libreoffice"     )
    , ("M-o v", spawn "virt-manager"    )
    , ("M-o f", spawn "zathura"         )
    , ("M-o k", spawn "pavucontrol"     )
    , ("M-o '", runInTerm "-t cmatrix" "cmatrix")

    , ("M-$", runInTerm "-t htop"    "htop")

    , ("M-S-s r", spawn "systemctl reboot"   )
    , ("M-S-s s", spawn "systemctl suspend"  )
    , ("M-S-s h", spawn "systemctl hibernate")
    , ("M-S-s o", spawn "systemctl poweroff" )
    , ("M-s",     spawn "screenlocker"       ) -- a wrapped script

    , ("M-n",   spawn "dunstctl close"      )
    , ("M-S-n", spawn "dunstctl close-all"  )
    , ("M-C-n", spawn "dunstctl history-pop")

    -- basic window
    , ("M-<Return>"  , spawn $ terminal conf             )
    , ("M-C-<Return>", spawn "pcmanfm"                   )
    , ("M-S-<Return>", spawn "emacsclient -c"            )
    , ("M-S-c"       , kill                              )
    , ("M-C-<Space>" , setLayout $ layoutHook conf       )
    , ("M-S-<Space>" , sendMessage NextLayout            )
    , ("M-r"         , refresh                           )

    -- move focus up or down the window stack
    , ("M-<Tab>"    , windows focusDown  )
    , ("M-S-<Tab>"  , windows focusUp    )
    , ("M-C-<Tab>"  , windows swapDown   )
    , ("M-C-S-<Tab>", windows swapUp     )
    , ("M-m"        , windows focusMaster)
    , ("M-S-m"      , windows swapMaster )

    -- resizing the master/slave ratio
    , ("M-(", sendMessage Shrink)
    , ("M-)", sendMessage Expand)

    -- floating layer support
    , ("M-t"  , withFocused $ windows . sink)
    , ("M-S-t", withFocused float           )

    -- increase or decrease number of windows in the master area
    , ("M-S-(", sendMessage (IncMasterN (-1)))
    , ("M-S-)", sendMessage (IncMasterN 1   ))

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
    , ("M-C-.", nextMatch History (pure True))

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
    , ("M-C-{" , swapTo Prev )
    , ("M-C-}" , swapTo Next )
    , ("M-C-," , toggleWS    )

    -- dynamic workspace
    , ("M-,"  , workspacePrompt myXPConf (windows . view ))
    , ("M-S-,", workspacePrompt myXPConf (windows . shift))
    , ("M-w"  , addWorkspacePrompt myXPConfNoAc)
    , ("M-S-w", removeWorkspace                )
    , ("M-C-w", renameWorkspace    myXPConfNoAc)

    -- change pwd for current workspace
    , ("M-c", changeDir myXPConfNoAc)

    -- hide windows
    , ("M-d"  , withFocused minimizeWindow)
    , ("M-S-d", withFocused maximizeWindow)
    , ("M-h"  , withFirstMinimized maximizeWindow)
    , ("M-S-h", withLastMinimized maximizeWindow)
    , ("M-C-h", withMinimized $ foldr ((<>) . maximizeWindow) mempty)

    -- fcitx clipboard history to paste

    -- password-store
    , ("M-'"  , passPrompt         myXPConf)
    , ("M-S-'", passOTPPrompt      myXPConf)

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
                  . minimize

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

myLoghook = historyHook
         <> updatePointer (0.5, 0.5) (0, 0)

myDef = def
    { modMask            = myModMask
    , terminal           = myTerm
    , keys               = myKeys
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
