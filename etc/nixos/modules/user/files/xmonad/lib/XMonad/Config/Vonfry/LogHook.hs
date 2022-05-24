module XMonad.Config.Vonfry.LogHook (logHook) where

import XMonad.Actions.UpdatePointer (updatePointer)

import XMonad.Actions.GroupNavigation (historyHook)

logHook = historyHook <> updatePointer (0.5, 0.5) (0, 0)
