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
          figlet
        ];
      }
    ];
  };

  xcfg = {
    programs = {
      feh.enable = true;

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
        PDFVIEWER = "emacsclient -n";
      };

      packages = with pkgs; [
        virt-manager
        mission-center
      ];
    };
  };

  xdgcfg = {
    xdg = {
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
