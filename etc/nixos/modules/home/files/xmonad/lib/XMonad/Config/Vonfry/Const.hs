module XMonad.Config.Vonfry.Const where

import Data.List (intercalate)

font' = ["Rec Mono Casual", "Noto Sans CJK SC"]

mkFontSize :: [Int] -> String
mkFontSize sizes = "xft:" ++ join
  where
    mkSuffix (font, size) = font ++ "-" ++ show size
    withSize = mkSuffix <$> zip font' sizes
    join = intercalate "," withSize


font = mkFontSize $ repeat 11

fontXL = mkFontSize $ repeat 32
