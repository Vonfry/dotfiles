{ config, pkgs, ... }:

{
  programs.chromium.enable = true;
  environment.systemPackages = with pkgs; [
    xclip
  ];
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    autorun = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  imports = with import (dirOf <nixos-config> + /libs);
    matchFiles ./. "^default\\.local\\.nix" [];
}
