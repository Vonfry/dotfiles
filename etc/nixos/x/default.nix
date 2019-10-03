{ config, pkgs, ... }:

{
  programs.chromium.enable = true;
  environment.systemPackages = with pkgs; [
    xclip
    alacritty
  ];
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    autorun = true;
    displayManager.sddm = {
      enable = true;
      theme = "maldives";
    };
    windowManager = {
      default = "xmonad";
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
  imports = [ ./default.local.nix ];
}
