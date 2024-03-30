module XMonad.Config.Vonfry.Key (key) where

import qualified XMonad.Config.Vonfry.Const as C
import qualified XMonad.Config.Vonfry.Color as Color

import XMonad ( refresh, io, spawn
              , def, windows , withFocused, whenJust

              , layoutHook, setLayout, Resize(..)

              , kill, float, killWindow, gets, windowset

              , XConfig(..)
              , xK_a, xK_o, xK_e, xK_u, xK_i, xK_d, xK_h, xK_t, xK_n, xK_s
              , xK_Escape, xK_Control_L

              , sendMessage, ChangeLayout(NextLayout)
              , IncMasterN(IncMasterN)
              )
import XMonad.StackSet ( focusDown, focusUp, focusMaster
                       , focusWindow
                       , swapMaster, swapDown, swapUp
                       , sink, shift, view
                       )
import qualified XMonad.StackSet as W
import XMonad.Actions.Navigation2D ( windowGo, windowSwap
                                   , screenGo, screenSwap, windowToScreen
                                   )

import XMonad.Util.EZConfig (mkKeymap)

import XMonad.Util.Run (runInTerm)
import XMonad.Util.Types (Direction1D(..), Direction2D(..))

import XMonad.Prompt (XPConfig(..))
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.FuzzyMatch (fuzzyMatch, fuzzySort)
import XMonad.Prompt.Pass (passPrompt, passOTPPrompt)
import XMonad.Prompt.Man (manPrompt)
import XMonad.Prompt.Ssh (sshPrompt)
import XMonad.Prompt.XMonad (xmonadPrompt)
import XMonad.Actions.Search (promptSearch, multi)

import XMonad.Prompt.Window ( windowMultiPrompt, allWindows, allApplications
                            , WindowPrompt(..)
                            )
import XMonad.Actions.EasyMotion ( EasyMotionConfig(..), ChordKeys(..)
                                 , selectWindow
                                 )

import XMonad.Layout.LayoutCombinators (JumpToLayout(JumpToLayout))
import XMonad.Actions.Minimize ( minimizeWindow, maximizeWindow
                               , withFirstMinimized, withLastMinimized
                               , withMinimized
                               )

import XMonad.Prompt.Workspace (workspacePrompt)
import XMonad.Actions.CycleWS ( nextWS, prevWS, shiftToNext, shiftToPrev
                              , toggleWS
                              )
import XMonad.Actions.DynamicWorkspaces ( addWorkspacePrompt, removeWorkspace
                                        , renameWorkspace
                                        )
import XMonad.Actions.WorkspaceNames (swapTo)
import XMonad.Layout.WorkspaceDir (changeDir)
import XMonad.Actions.GroupNavigation (nextMatch, Direction(History))
import XMonad.Actions.FocusNth (swapNth)

import System.Exit (exitWith, ExitCode(ExitSuccess))

import Data.Function (on)
import qualified Data.List as L

key conf = mkKeymap conf
    [ ("M-x"  , shellPrompt promptConfig           )
    , ("M-S-x", shellPrompt promptConfigNoAc       )
    , ("M-C-x", xmonadPrompt promptConfig          )
    , ("M-/"  , promptSearch promptConfigNoAc multi)
    , ("M-z"  , sshPrompt promptConfig             )

    , ("M-<F1>"  , manPrompt promptConfig)

    , ("M-o b", spawn "nyxt"        )
    , ("M-o o", spawn "libreoffice" )
    , ("M-o v", spawn "virt-manager")
    , ("M-o f", spawn "zathura"     )
    , ("M-o '", runInTerm "-t cmatrix" "cmatrix")

    , ("M-$", runInTerm "-t top"  "btop")

    , ("M-S-s r", spawn "reboot"   )
    , ("M-S-s s", spawn "suspend"  )
    , ("M-S-s h", spawn "hibernate")
    , ("M-S-s o", spawn "poweroff" )
    , ("M-s",     spawn "screenlocker") -- a wrapped script

    , ("M-n",   spawn "dunstctl close"      )
    , ("M-S-n", spawn "dunstctl close-all"  )
    , ("M-C-n", spawn "dunstctl history-pop")

    -- basic window
    , ("M-<Return>"  , spawn $ terminal conf      )
    , ("M-C-<Return>", spawn "emacsclient -c ."   )
    , ("M-S-<Return>", spawn "emacsclient -c"     )
    , ("M-S-c"       , kill                       )
    , ("M-S-<Space>" , sendMessage NextLayout     )
    , ("M-C-<Space>" , setLayout $ layoutHook conf)
    , ("M-r"         , refresh                    )
    -- We use M-<Space> for input methods

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
    , ("M-a"  , spawn "flameshot gui   ")
    , ("M-S-a", spawn "flameshot screen")
    , ("M-C-a", spawn "flameshot full  ")

    -- switch window
    , ("M-.", windowMultiPrompt promptConfig $
        (\d -> (d, allWindows)) <$> [ Goto
                                    , Bring
                                    , BringToMaster
                                    , BringCopy
                                    ])
    , ("M-S-.", windowMultiPrompt promptConfig $
        (\d -> (d, allApplications)) <$> [ Goto
                                         , Bring
                                         , BringToMaster
                                         , BringCopy
                                         ])

    -- window navigation
    , ("M-C-.", nextMatch History (pure True))

    -- layout select
    , ("M-; d"  , sendMessage $ JumpToLayout "DragV"  )
    , ("M-; g"  , sendMessage $ JumpToLayout "Grid"   )
    , ("M-; v"  , sendMessage $ JumpToLayout "GridL"  )
    , ("M-; c"  , sendMessage $ JumpToLayout "Column" )
    , ("M-; t"  , sendMessage $ JumpToLayout "Tiled"  )
    , ("M-; f"  , sendMessage $ JumpToLayout "Full"   )
    , ("M-S-; t", sendMessage $ JumpToLayout "MTiled" )
    , ("M-S-; c", sendMessage $ JumpToLayout "MColumn")
    , ("M-S-; d", sendMessage $ JumpToLayout "DragH"  )

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
    , ("M-C-<Left>" , screenSwap L True)
    , ("M-C-<Down>" , screenSwap D True)
    , ("M-C-<Up>"   , screenSwap U True)
    , ("M-C-<Right>", screenSwap R True)

    -- Send window to adjacent screen
    , ("M-S-<Left>" , windowToScreen L True)
    , ("M-S-<Down>" , windowToScreen D True)
    , ("M-S-<Up>"   , windowToScreen U True)
    , ("M-S-<Right>", windowToScreen R True)

    -- cycle workspace
    , ("M-}"  , nextWS     )
    , ("M-{"  , prevWS     )
    , ("M-S-}", shiftToNext)
    , ("M-S-{", shiftToPrev)
    , ("M-C-{", swapTo Prev)
    , ("M-C-}", swapTo Next)
    , ("M-C-,", toggleWS   )

    -- easy motion
    , ("M-g"  , selectWindow emConfig >>= (`whenJust` windows . focusWindow))
    , ("M-S-g", do
          sel <- selectWindow emConfig
          stack <- gets $ W.index . windowset
          let match = L.find ((sel ==) . Just . fst) $ zip stack [0..]
          whenJust match $ swapNth . snd)
    , ("M-C-g", selectWindow emConfig >>= (`whenJust` on (flip (<>)) windows swapMaster . focusWindow))
    , ("M-C-c", selectWindow emConfig >>= (`whenJust` killWindow))

    -- dynamic workspace
    , ("M-,"  , workspacePrompt promptConfig (windows . view ))
    , ("M-S-,", workspacePrompt promptConfig (windows . shift))
    , ("M-w"  , addWorkspacePrompt promptConfigNoAc)
    , ("M-S-w", removeWorkspace                    )
    , ("M-C-w", renameWorkspace    promptConfigNoAc)

    -- change pwd for current workspace
    , ("M-c", changeDir promptConfigNoAc)

    -- hide windows
    , ("M-d"  , withFocused minimizeWindow)
    , ("M-S-d", withFocused maximizeWindow)
    , ("M-h"  , withFirstMinimized maximizeWindow)
    , ("M-S-h", withLastMinimized maximizeWindow)
    , ("M-C-h", withMinimized $ foldr ((<>) . maximizeWindow) mempty)

    -- fcitx clipboard history to paste

    -- password-store
    , ("M-'"  , passPrompt    promptConfig)
    , ("M-S-'", passOTPPrompt promptConfig)

    -- midia keys
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" )
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" )
    , ("<XF86AudioMute>"       , spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
    ]

promptConfig = def
    { font              = C.font
    , searchPredicate   = fuzzyMatch
    , sorter            = fuzzySort
    , bgColor           = Color.background
    , fgColor           = Color.foreground
    , bgHLight          = Color.yellow
    , fgHLight          = Color.selection
    , borderColor       = Color.purple
    , promptBorderWidth = 2
    -- use this to avoid pass unexpected key to applications
    , autoComplete      = Just $ 2 * 10 ^ 5
    , height            = 30
    , changeModeKey     = xK_Control_L
    }

promptConfigNoAc = promptConfig { autoComplete = Nothing }

emConfig = def { txtCol      = Color.foreground
               , bgCol       = Color.background
               , borderCol   = Color.purple
               , borderPx    = 2
               , sKeys       = AnyKeys [xK_a, xK_o, xK_e, xK_u, xK_i, xK_d,
                                        xK_h, xK_t, xK_n, xK_s]
               , cancelKey   = xK_Escape
               , emFont      = C.fontXL
               }
