{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    programs = {
      feh.enable = true;

      zathura = {
        enable = true;
        extraConfig = ''
          map T recolor
        '';
        options = {
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

      mpv.enable = true;

      gpg = {
        enable = true;
        settings = {
          keyserver = "hkps://keys.openpgp.org";
        };
      };

      password-store = {
        enable = true;
      };
    };

    home = {
      activation = {
        financialActivation =
          let
            sessions = config.home.sessionVariables;
          in lib.hm.dag.entryAfter ["shellActivation"] (optionalString (sessions ? "LEDGER_FILE" && sessions ? "CLOUD_DIR") (
            let
              FILE = sessions.LEDGER_FILE;
              inherit (sessions) CLOUD_DIR;
            in ''
              [ ! -h $(dirname ${FILE}) ] && ln -s ${CLOUD_DIR}/dotfiles/financial $(dirname ${FILE})
              if [ ! -f ${FILE} ]; then
                touch ${FILE}
                echo "include header.journal\nY$(date +%Y)\n"
                echo "New year financial file is created. Please check it(${FILE})."
                exit -1
              fi
            ''
          ));
      };

      sessionVariables =  mkMerge [
        {
          PDFVIEWER = "zathura";
        }
        (mkOrder 2000 {
          # Use mkOrder to make sure this is override the default one by
          # home-manager, because sessionVariables' type is `types.attrs`.`
          # Use this to fix remote computer pam and other problems.
          SSH_AUTH_SOCK = "\${SSH_AUTH_SOCK:-$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)}";
        })
      ];

      packages = with pkgs; [
        fortune cmatrix figlet

        hledger

        tdesktop

        # remmina
        filezilla

        flameshot feh # inkscape gimp
        pavucontrol # kid3 audacity
        # mpv ffmpeg
        unstable.tor-browser-bundle-bin
        # zathura
        libreoffice

        virt-manager
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
        "application/pdf"               = "org.pwmt.zathura.desktop";
      };
    };

    services = {
      pulseeffects.enable = true;

      mpd = {
        enable = mkDefault true;
        musicDirectory = mkDefault "${config.home.homeDirectory}/Music";
      };

      gpg-agent = {
        enable = true;
        defaultCacheTtl = 14400;
        enableSshSupport = true;
        enableExtraSocket = true;
        enableScDaemon = true;
        pinentryFlavor = "curses";
        extraConfig = ''
          allow-emacs-pinentry
          allow-preset-passphrase
        '';
      };
    };
  };
}
