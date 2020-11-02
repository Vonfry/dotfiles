{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      font = {
        name = "monospace";
      };
      theme = {
        name = "Dracula";
        package = pkgs.unstable.dracula-theme;
      };
      iconTheme = {
        name = "breeze-dark";
        package = pkgs.breeze-icons;
      };
    };

    qt = {
      enable = mkDefault false;
      platformTheme = "gtk";
    };

    programs = {
      alacritty = {
        settings = import ./files/alacritty.nix;
        enable = true;
      };
    };

    xsession = {
      enable = true;
      initExtra = ''
        feh --bg-center ${toString config.xdg.configHome}/bg.png
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
          font = "monospace";
          markup = true;
          plain_text = false;
          format = "<b>%s</b>\\n%b";
          sort = false;
          indicate_hidden = true;
          alignment = "center";
          bounce_freq = 0;
          show_age_threshold = -1;
          word_wrap = true;
          ignore_newline = false;
          stack_duplicates = true;
          hide_duplicates_count = true;
          geometry = "300x50-15+49";
          shrink = false;
          transparency = 5;
          idle_threshold = 0;
          monitor = 0;
          follow = "none";
          sticky_history = true;
          history_length = 15;
          show_indicators = false;
          line_height = 3;
          separator_height = 2;
          padding = 6;
          horizontal_padding = 6;
          separator_color = "frame";
          startup_notification = false;
          browser = "qutebrowser";
          icon_position = "off";
          max_icon_size = 80;
          frame_width = 3;
          frame_color = "#8EC07C";
        };
        urgency_low = {
          frame_color = "#3B7C87";
          foreground = "#3B7C87";
          background = "#191311";
          timeout = 4;
        };
        urgency_normal = {
          frame_color = "#5B8234";
          foreground = "#5B8234";
          background = "#191311";
          timeout = 6;
        };
        urgency_critical = {
          frame_color = "#B7472A";
          foreground = "#B7472A";
          background = "#191311";
          timeout = 8;
        };
      };
    };

    home.packages = with pkgs; [
      tigervnc

      # alacritty
    ];

    xdg = {
      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
      dataFile = {
        "applications/org-protocol.desktop".text = ''
          [Desktop Entry]
          Name=org-protocol
          Exec=emacsclient %u
          Type=Application
          Terminal=false
          Categories=System;
          MimeType=x-scheme-handler/org-protocol;
        '';
      };
    };
  };
}