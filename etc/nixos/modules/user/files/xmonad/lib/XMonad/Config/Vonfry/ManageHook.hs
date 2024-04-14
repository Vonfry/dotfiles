module XMonad.Config.Vonfry.ManageHook (manageHook) where

import XMonad (def, doIgnore, (-->))

import XMonad.Hooks.ManageHelpers (isInProperty)

manageHook = mconcat
    [ def
    , isUtility --> doIgnore
    ]
  where
    isUtility = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_UTILITY"
