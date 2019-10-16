{ pkgs, customPkgs, ... }:

let
  appimage-run-with-extra = customPkgs.appimage-run;
in with pkgs; [
  tdesktop
  appimage-run-with-extra
]
