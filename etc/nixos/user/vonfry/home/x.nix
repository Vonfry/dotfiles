{ pkgs, ... }:

let
  conf = {
    gtk = {
      enable = true;
      gtk = {
        font = {
          name = "Source Han Sans CN";
          package = source-han-sans-simplified-chinese
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
    };
    qt = {
      enable = true;
      platformTheme = "gtk";
    };
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./files/xmonad.hs;
    };
    services.dunst = {
      enable = true;
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
    programs.alacritty = import ./files/alacritty.nix;
  };
in
if (!pkgs.stdenv.isDarwin) then conf else {}
