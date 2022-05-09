module XMonad.Config.Vonfry (config) where

import qualified XMonad.Config.Vonfry.Key as Key
import qualified XMonad.Config.Vonfry.Const as C
import qualified XMonad.Config.Vonfry.Color as Color
import qualified XMonad.Config.Vonfry.LogHook as LogHook
import qualified XMonad.Config.Vonfry.ManageHook as ManageHook
import qualified XMonad.Config.Vonfry.LayoutHook as LayoutHook

import XMonad (def, XConfig(..), mod4Mask)

import XMonad.Actions.Navigation2D (withNavigation2DConfig)

realConfig = def
    { modMask            = mod4Mask
    , terminal           = C.terminal
    , keys               = Key.key
    , layoutHook         = LayoutHook.layoutHook
    , focusFollowsMouse  = True
    , focusedBorderColor = Color.purple
    , normalBorderColor  = Color.comment
    , borderWidth        = 1
    , workspaces         = [ "home", "doc", "web", "taichi", "misc", "bg", "vm",
                             "magic", "play"
                           ]
    , logHook            = LogHook.logHook
    , manageHook         = ManageHook.manageHook
    }

beforeConfig = withNavigation2DConfig def

config = beforeConfig realConfig

