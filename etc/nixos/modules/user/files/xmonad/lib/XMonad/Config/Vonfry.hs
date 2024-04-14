module XMonad.Config.Vonfry (config) where

import qualified XMonad.Config.Vonfry.Key as Key
import qualified XMonad.Config.Vonfry.Const as C
import qualified XMonad.Config.Vonfry.Color as Color
import qualified XMonad.Config.Vonfry.LogHook as LogHook
import qualified XMonad.Config.Vonfry.ManageHook as ManageHook
import qualified XMonad.Config.Vonfry.LayoutHook as LayoutHook
import qualified XMonad.Config.Vonfry.StartupHook as StartupHook

import XMonad (def, XConfig(..), mod4Mask)

import XMonad.Actions.Navigation2D
    ( withNavigation2DConfig, Navigation2DConfig(..)
    , hybridOf, lineNavigation, sideNavigation
    )

realConfig = def
    { modMask            = mod4Mask
    , terminal           = C.terminal
    , keys               = Key.key
    , layoutHook         = LayoutHook.layoutHook
    , focusFollowsMouse  = True
    , focusedBorderColor = Color.purple
    , normalBorderColor  = Color.comment
    , borderWidth        = 2
    , workspaces         = [ "home", "doc", "web", "taichi", "misc", "bg", "vm",
                             "magic", "play"
                           ]
    , logHook            = LogHook.logHook
    , manageHook         = ManageHook.manageHook
    , startupHook        = StartupHook.startupHook
    }

beforeConfig = withNavigation2DConfig nav2dConfig
  where
    nav2dConfig = def
        { defaultTiledNavigation = hybridOf lineNavigation sideNavigation
        }

config = beforeConfig realConfig

