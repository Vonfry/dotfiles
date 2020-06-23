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
    programs = {
      feh.enable = true;
      zathura.enable = true;
      alacritty = {
        settings = import ./files/alacritty.nix;
	enable = true;
      };
      firefox.enable = true;
    };
    xsession = {
      enable = true;
      initExtra = ''
        source ~/.zprofile
        feh --bg-center ~/.config/bg.png
      '';
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./files/xmonad.hs;
      };
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
  };
in
if (!pkgs.stdenv.isDarwin) then conf else {}
