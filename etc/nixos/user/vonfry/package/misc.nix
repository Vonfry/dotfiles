{ pkgs, lib, customPkgs, ... }:

with pkgs; [
  _1password

  customPkgs.fira-code-symbols
] ++ lib.optionals (!stdenv.isDarwin) [
  tdesktop
  filezilla
  fontforge-gtk

  hack-font
  source-han-sans-simplified-chinese
  source-han-serif-simplified-chinese
  symbola
  liberation_ttf

  # dunst
]
