{ config, pkgs, ... }:

{
  programs.chromium.enable = true;
  environment.systemPackages = with pkgs; [
    xclip
    alacritty
    firefox
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
