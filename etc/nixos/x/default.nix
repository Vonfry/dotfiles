{ config, pkgs, ... }:

{
  programs.chromium.enable = true;
  environment.systemPackages = with pkgs; [
  ];
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    autorun = false;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  imports = with import (dirOf <nixos-config> + /libs); 
    matchFiles ./. "^x\\.local\\.nix" [];
}
