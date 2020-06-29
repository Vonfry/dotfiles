{-# LANGUAGE LambdaCase #-}

import XMonad hiding ((|||))
import XMonad.Util.EZConfig
import XMonad.Actions.Search
import XMonad.Actions.WindowMenu
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
import XMonad.StackSet
import Data.Ratio
import System.IO

-- auxiliary configuration
myFont = "xft:Hack:size=9"
myFontCJK = "xft:Source Han Sans CN:size=11"
myFontCJKSmall = "xft:Source Han Sans CN:size=9"
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
    , borderColor     = draculaPuple
    , autoComplete    = Just $ 2 * 10 ^ 5 -- 0.2s
    }

-- my configurations

myKeys conf = mkKeymap conf
    [ ("M-x"  , shellPrompt myXPConf       )
    , ("M-S-x", xmonadPrompt myXPConf      )
    , ("M-/"  , promptSearch myXPConf multi)

    , ("M-, d" , spawn "zeal"            )
    , ("M-, b" , spawn "qutebrowser"     )
    , ("M-, B" , runInTerm "" "w3m"      )
    , ("M-, a" , runInTerm "" "alsamixer")
    , ("M-, D" , spawn "libreoffice"     )
    , ("M-, V" , spawn "VirtualBox"      )
    , ("M-, v" , spawn "zathura"         )
    , ("M-, t" , spawn "telegram-desktop")
    , ("M-, m" , spawn "vlc"             )
    , ("M-, '" , spawn "emacs"           )

    -- basic window
    , ("M-'"         , spawn $ runInTerm "" "ranger"     )
    , ("M-S-<Return>", spawn $ XMonad.terminal conf      )
    , ("M-S-c"       , kill                              )
    , ("M-S-<Space>" , setLayout $ XMonad.layoutHook conf)
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
    , ("M-S-t", withFocused float                 )

    -- increase or decrease number of windows in the master area
    , ("M-[", sendMessage (IncMasterN (-1)))
    , ("M-]", sendMessage (IncMasterN 1   ))

    -- quit, or restart
    , ("M-S-q", io (exitWith ExitSuccess))
    , ("M-q"  , spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")

    -- help
    , ("M-?", helpCommand)

    -- screenshot
    , ("M-<Print>"  , spawn "flameshot gui    -p ~/screenshot/" )
    , ("M-S-<Print>", spawn "flameshot screen -p ~/screenshot/" )
    , ("M-C-<Print>", spawn "flameshot full   -p ~/screenshot"  )

    -- Switch between layers
    , ("M-<Space>", switchLayer)

    -- switch window
    , ("M-.", mkXPromptWithModes [Goto, Bring, BringToMaster, BringCopy]
                                 myXPConf) -- TODO test

    -- layout select
    , ("M-;", layoutPrompt myXPConf) -- TODO test

    -- Directional navigation of windows
    , ("M-l", windowGo R False)
    , ("M-h", windowGo L False)
    , ("M-j", windowGo U False)
    , ("M-k", windowGo D False)

    -- Swap adjacent windows
    , ("M-S-l", windowSwap R False)
    , ("M-S-h", windowSwap L False)
    , ("M-S-j", windowSwap U False)
    , ("M-S-k", windowSwap D False)

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
    , ("M-}"  , nextWS                               )
    , ("M-{"  , prevWS                               )
    , ("M-S-}", shiftToNext                          )
    , ("M-S-{", shiftToPrev                          )
    , ("M-S-.", toggleWS                             )
    , ("M-g"  , workspacePrompt def (windows . shift))

    -- change pwd for current workspace
    , ("M-p", changeDir myXPConf)

    -- hide windows
    , ("M-d"  , withFocused hideWindow)
    , ("M-S-d", popOldestHiddenWindow)
    -- paste
    , ("M-y", pasteSelection)

    -- window menu
    , ("M-w", windowMenu)
    ]

myLayout = beforeLayouts layouts
  where
    layouts =
            renamed [ Replace "Tab" ] (noBorders $ tabbed shrinkText def
                { inactiveBorderColor = draculaComment
                , activeBorderColor   = draculaPurple
                , inactiveTextColor   = draculaForeground
                , activeTextColor     = draculaForeground
                , inactiveColor       = draculaBackground
                , activeColor         = draculaSelection
                , fontName            = myFontCJKSmall
                , decoHeight          = 20
                })
        ||| renamed [ Replace "Tiled"     ] tiled
        ||| renamed [ Replace "GridL"     ] (SplitGrid L 2 3 (2/3) (16/10) (1/100))
        ||| renamed [ Replace "DragV"     ] (dragPane Vectial -2.1 0.5 )
        ||| renamed [ Replace "Grid"      ] (Grid (16/10))
        ||| renamed [ Replace "DragH"     ] (dragPane Horizontal 0.1 0.5 )
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
    , focusedBorderColor = draculaPurple
    , normalBorderColor  = draculaComment
    , borderWidth        = 1
    , workspaces         = myWorkspaces
    }

-- main
main = xmonad myDef

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
