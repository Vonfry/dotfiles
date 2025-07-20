module XMonad.Config.Vonfry.Const where

import Data.List (intercalate)

font' = ["Rec Mono Casual", "Source Han Mono SC"]

mkFontSize size = "xft:" ++ join
  where
    suffix = "-" ++ show size
    withSize = fmap (++suffix) font'
    join = intercalate "," withSize


font = mkFontSize 11

fontXL = mkFontSize 32
