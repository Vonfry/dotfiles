{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xclip
    alacritty
    firefox
    dunst libnotify
  ];
  services.xbanish.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    autorun = true;
    displayManager.sddm = {
      enable = true;
      theme = "elarun";
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
