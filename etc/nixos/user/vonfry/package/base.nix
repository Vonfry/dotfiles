{ lib, pkgs, ... }:

with pkgs; [
] ++ lib.optional (!stdenv.isDarwin) [
  lnav
  exfat
]
