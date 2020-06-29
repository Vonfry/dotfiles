{ lib, pkgs, ... }:

with pkgs; [
] ++ lib.optionals stdenv.isLinux [
  lnav
  exfat
]
