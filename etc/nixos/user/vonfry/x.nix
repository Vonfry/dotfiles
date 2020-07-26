{ config, lib, pkgs, ... }:

let
  defvarFile = builtins.concatStringsSep "/" [ "$HOME"
                                               config.programs.zsh.dotDir
                                               "defvar.sh"
                                             ];
  localvarFile = builtins.concatStringsSep "/" [ "$HOME"
                                                 config.programs.zsh.dotDir
                                                 "localvar.sh"
                                               ];
in {
  gtk = {
    enable = true;
    font = {
      name = "monospace";
    };
    theme = {
      name = "Ant-Dracula";
      package = pkgs.vonfryPackages.unstable.ant-dracula-theme;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.breeze-icons;
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
  };

  xsession = {
    enable = true;
    profileExtra = ''
      [ -f ${defvarFile} ] && . ${defvarFile}
      [ -f ${localvarFile} ] && . ${localvarFile}
    '';
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
        format = "<b>%s</b>\n%b";
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
        follow = false;
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
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
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
    gnuplot

    tigervnc
    feh
    cmus
    mpv
    inkscape
    gimp
    unstable.tor-browser-bundle-bin
    zerotierone
    handbrake # numactl works on linux # wait for pr https://github.com/NixOS/nixpkgs/pull/89674
    zathura
    libreoffice
  ];

  xdg = {
    enable = true;
    userDirs.enable = true;
    mimeApps = {
       enable = true;
       defaultApplications = {
         "x-scheme-handler/http"         = "org.qutebrowser.qutebrowser.desktop";
         "x-scheme-handler/https"        = "org.qutebrowser.qutebrowser.desktop";
         "x-scheme-handler/ftp"          = "org.qutebrowser.qutebrowser.desktop";
         "x-scheme-handler/chrome"       = "org.qutebrowser.qutebrowser.desktop";
         "text/html"                     = "org.qutebrowser.qutebrowser.desktop";
         "application/x-extension-htm"   = "org.qutebrowser.qutebrowser.desktop";
         "application/x-extension-html"  = "org.qutebrowser.qutebrowser.desktop";
         "application/x-extension-shtml" = "org.qutebrowser.qutebrowser.desktop";
         "application/xhtml+xml"         = "org.qutebrowser.qutebrowser.desktop";
         "application/x-extension-xhtml" = "org.qutebrowser.qutebrowser.desktop";
         "application/x-extension-xht"   = "org.qutebrowser.qutebrowser.desktop";
       };
    };
  };
}
