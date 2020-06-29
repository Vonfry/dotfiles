{ lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  gtk = {
    enable = isLinux;
    font = {
      name = "Source Han Sans CN";
      package = pkgs.source-han-sans-simplified-chinese;
    };
    theme = {
      name = "Ant-Dracula";
      package = pkgs.ant-dracula-theme;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.breeze-icons;
    };
  };
  qt = {
    enable = isLinux;
    platformTheme = "gtk";
  };
  programs = {
    feh.enable = isLinux;
    zathura.enable = isLinux;
    alacritty = {
      settings = import ./files/alacritty.nix;
      enable = isLinux;
    };
    firefox.enable = isLinux;
  };
  xsession = {
    enable = isLinux;
    initExtra = ''
      source ~/.zprofile
      feh --bg-center ~/.config/bg.png
    '';
    windowManager.xmonad = {
      enable = isLinux;
      enableContribAndExtras = true;
      config = ./files/xmonad.hs;
    };
  };
  services.dunst = {
    enable = isLinux;
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.breeze-icons;
    };
    settings = {
      global = {
        font = "Source Han Sans CN";
      };
    };
  };
}
