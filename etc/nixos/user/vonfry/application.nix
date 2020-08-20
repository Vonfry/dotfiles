{ pkgs, lib, config, ... }:

{
  programs = {
    feh.enable = true;
    zathura = {
      enable = true;
      extraConfig = ''
        map t recolor
      '';
      options = {
        incremental-search      = true;
        font                    = "monospace normal 11";
        notification-error-bg   = "#ff5555"; # Red
        notification-error-fg   = "#f8f8f2"; # Foreground
        notification-warning-bg = "#ffb86c"; # Orange
        notification-warning-fg = "#44475a"; # Selection
        notification-bg         = "#282a36"; # Background
        notification-fg         = "#f8f8f2"; # Foreground
        completion-bg           = "#282a36"; # Background
        completion-fg           = "#6272a4"; # Comment
        completion-group-bg     = "#282a36"; # Background
        completion-group-fg     = "#6272a4"; # Comment
        completion-highlight-bg = "#44475a"; # Selection
        completion-highlight-fg = "#f8f8f2"; # Foreground
        index-bg                = "#282a36"; # Background
        index-fg                = "#f8f8f2"; # Foreground
        index-active-bg         = "#44475a"; # Current Line
        index-active-fg         = "#f8f8f2"; # Foreground
        inputbar-bg             = "#282a36"; # Background
        inputbar-fg             = "#f8f8f2"; # Foreground
        statusbar-bg            = "#282a36"; # Background
        statusbar-fg            = "#f8f8f2"; # Foreground
        highlight-color         = "#ffb86c"; # Orange
        highlight-active-color  = "#ff79c6"; # Pink
        default-bg              = "#282a36"; # Background
        default-fg              = "#f8f8f2"; # Foreground
        render-loading          = true     ;
        render-loading-fg       = "#282a36"; # Background
        render-loading-bg       = "#f8f8f2"; # Foreground
        recolor-lightcolor      = "#282a36"; # Background
        recolor-darkcolor       = "#f8f8f2"; # Foreground
      };
    };
  };

  home = {
    activation = {
      financialActivation =
        let
          FILE = config.home.sessionVariables.LEDGER_FILE;
        in lib.hm.dag.entryAfter ["shellActivation"] ''
          [ ! -h $(dirname ${FILE}) ] && ln -s ${config.home.sessionVariables.CLOUD_DIR}/financial $(dirname ${FILE})
          if [ ! -f ${FILE} ]; then
            touch ${FILE}
            echo "include header.journal\nY$(date +%Y)\n"
            echo "New year financial file is created. Please check it(${FILE})."
            exit -1
          fi
        '';
    };

    packages = with pkgs; [
      fortune cmatrix figlet

      hledger
      unstable._1password-gui

      tdesktop

      ranger
      filezilla

      flameshot feh # inkscape gimp
      pavucontrol cmus # kid3 audacity
      mpv # ffmpeg
      unstable.tor-browser-bundle-bin
      zathura
      libreoffice
    ];
  };

  xdg = {
    mimeApps.defaultApplications = {
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

  services = {
    pulseeffects.enable = true;

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 14400;
      enableSshSupport = true;
      extraConfig = ''
        allow-emacs-pinentry
        allow-preset-passphrase
      '';
    };
  };
}
