{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.vonfry;
  envcfg = config.vonfry.environment;

  isenable = cfg.application.enable;
  ishome = config.vonfry.workspace.home;

  appcfg = {
    programs = {
      gpg = {
        enable = true;
        settings = {
          keyserver = "hkps://keys.openpgp.org";
        };
      };

      password-store = {
        enable = true;
        package = pkgs.pass-nodmenu.withExtensions (exts: with exts; [ pass-otp ]);
      };

    };

    services = {
      gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        enableSshSupport = true;
        enableExtraSocket = true;
        enableScDaemon = true;
        pinentryPackage = pkgs.pinentry-gtk2;
        extraConfig = ''
          allow-loopback-pinentry
          allow-preset-passphrase
        '';
      };
    };

    home = mkMerge [
      (mkIf envcfg.financial.enable {
        packages = with pkgs; [ hledger ];
        sessionVariables = {
          # HOLD This should update every year manually.
          "LEDGER_FILE" = "${envcfg.financial.absolute_path}/2025.journal";
        };
      })
      {
        packages = with pkgs; [
          fortune
          cmatrix
          figlet
        ];
      }
    ];
  };

  xcfg = {
    programs = {
      feh.enable = true;

      zathura = {
        enable = true;
        extraConfig = ''
          map T recolor
        '';
        options = {
          font = "monospace normal 11";
          notification-error-bg = "#ff5555"; # Red
          notification-error-fg = "#f8f8f2"; # Foreground
          notification-warning-bg = "#ffb86c"; # Orange
          notification-warning-fg = "#44475a"; # Selection
          notification-bg = "#282a36"; # Background
          notification-fg = "#f8f8f2"; # Foreground
          completion-bg = "#282a36"; # Background
          completion-fg = "#6272a4"; # Comment
          completion-group-bg = "#282a36"; # Background
          completion-group-fg = "#6272a4"; # Comment
          completion-highlight-bg = "#44475a"; # Selection
          completion-highlight-fg = "#f8f8f2"; # Foreground
          index-bg = "#282a36"; # Background
          index-fg = "#f8f8f2"; # Foreground
          index-active-bg = "#44475a"; # Current Line
          index-active-fg = "#f8f8f2"; # Foreground
          inputbar-bg = "#282a36"; # Background
          inputbar-fg = "#f8f8f2"; # Foreground
          statusbar-bg = "#282a36"; # Background
          statusbar-fg = "#f8f8f2"; # Foreground
          highlight-color = "#ffb86c"; # Orange
          highlight-active-color = "#ff79c6"; # Pink
          default-bg = "#282a36"; # Background
          default-fg = "#f8f8f2"; # Foreground
          render-loading = true;
          render-loading-fg = "#282a36"; # Background
          render-loading-bg = "#f8f8f2"; # Foreground
          recolor-lightcolor = "#282a36"; # Background
          recolor-darkcolor = "#f8f8f2"; # Foreground
        };
      };

      mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [
          uosc
          mpv-cheatsheet
          mpv-playlistmanager
        ];
      };
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = config.xdg.userDirs.pictures;
        };
      };
    };

    home = {
      sessionVariables = {
        PDFVIEWER = "zathura";
      };

      packages = with pkgs; [
        libreoffice

        virt-manager
      ];
    };
  };

  xdgcfg = {
    xdg = {
      mimeApps.defaultApplications = {
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      };

      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
    };

    home.preferXdgDirectories = true;

    assertions = [
      {
        assertion = config.xdg.enable && config.xdg.userDirs.enable;
        message = "You must enable xdg and xdg's userDirs, because vonfry's module is highly depended on it for some paths.";
      }
    ];
  };

  homecfg = {
    services = {
      mpd = {
        enable = mkDefault true;
        musicDirectory = mkDefault "${config.xdg.userDirs.music}";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "My Pipewire Output"
          }
          restore_paused "yes"
        '';
      };
    };
  };
in
{
  options.vonfry.application = {
    enable = mkEnableOption "Vonfry's application configurations.";
  };
  config = mkMerge [
    { vonfry.application.enable = mkDefault cfg.enable; }
    (mkIf isenable appcfg)
    (mkIf cfg.enable xdgcfg)
    (mkIf (isenable && cfg.x.enable) xcfg)
    (mkIf (isenable && ishome) homecfg)
  ];
}
