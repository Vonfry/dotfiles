{ lib, pkgs, customPkgs, ... }:

with pkgs;
[ customPkgs.fira-code-symbols
] ++ lib.optional (!stdenv.isDarwin)
[ hack-font
  hack-font
  source-han-sans-simplified-chinese
  source-han-serif-simplified-chinese
  symbola
  liberation_ttf
]
