{ lib, pkgs, ... }:

with pkgs; [
] ++ lib.optionals (!stdenv.isDarwin) [
  lnav
  exfat
]
