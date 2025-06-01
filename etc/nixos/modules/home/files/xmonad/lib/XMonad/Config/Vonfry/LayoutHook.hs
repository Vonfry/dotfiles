module XMonad.Config.Vonfry.LayoutHook (layoutHook) where

import qualified XMonad.Config.Vonfry.Const as C
import qualified XMonad.Config.Vonfry.Color as Color

import XMonad (def, Tall(Tall), Full(Full), Mirror(Mirror))
import XMonad.Layout.LayoutCombinators ((|||))
import XMonad.Layout.Renamed (renamed, Rename(..))
import XMonad.Layout.ShowWName (showWName', SWNConfig(..))
import XMonad.Layout.Minimize (minimize)
import XMonad.Layout.GridVariants (SplitGrid(..), Grid(..))
import qualified XMonad.Layout.GridVariants as GridVariants
import XMonad.Layout.Column (Column(Column))
import XMonad.Layout.DragPane (dragPane, DragType(..))

import XMonad.Layout.Spacing (smartSpacing)

import Data.Ratio ((%))

layoutHook = beforeLayouts layouts
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
    splitGrid = SplitGrid GridVariants.L 2 3 (2/3) gridRatio (1/100)
    grid      = Grid gridRatio
    tiled     = Tall 1 (3/100) (1/2)
    drag d    = dragPane d 0.1 0.5
    column    = Column 1

    cleanupNames  = renamed [ CutWordsLeft 1 ]
    beforeLayouts = cleanupNames
                  . showWName' showWNameConfig
                  . minimize
                  . smartSpacing 2


showWNameConfig = def { swn_font    = C.font
                      , swn_bgcolor = Color.background
                      , swn_color   = Color.foreground
                      , swn_fade    = 1 % 1
                      }
