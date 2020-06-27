{ lib, pkgs, ... }:

let isDarwin = pkgs.stdenv.isDarwin;
in
{
  gtk = {
    enable = !isDarwin;
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
    enable = !isDarwin;
    platformTheme = "gtk";
  };
  programs = {
    feh.enable = !isDarwin;
    zathura.enable = !isDarwin;
    alacritty = {
      settings = import ./files/alacritty.nix;
      enable = !isDarwin;
    };
    firefox.enable = !isDarwin;
  };
  xsession = {
    enable = !isDarwin;
    initExtra = ''
      source ~/.zprofile
      feh --bg-center ~/.config/bg.png
    '';
    windowManager.xmonad = {
      enable = !isDarwin;
      enableContribAndExtras = true;
      config = ./files/xmonad.hs;
    };
  };
  home.file = lib.optionalAttrs (!isDarwin) {
    ".face.icon".source = builtins.fetchurl
      https://vonfry.name/static/images/default/logo.png;
  };
  services.dunst = {
    enable = !isDarwin;
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
