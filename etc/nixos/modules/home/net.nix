{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.vonfry.net;
  cfg' = config.vonfry;

  whether_emacsclient_email = config.services.emacs.enable && cfg.email != null;

  genEmacsModuleWarning =
    module:
    optional (any (
      x: x == module
    ) cfg'.development.emacs.excludeModules) "emacs ${module} module is disabled.";

  netcfg = {
    accounts.email = mkIf (cfg.email != null) {
      maildirBasePath = "${config.xdg.dataHome}/email";
      accounts = {
        vonfry = mkMerge [
          {
            realName = "Vonfry";
            primary = true;
            # other configurations are save in local
            maildir.path = "_";
            mbsync = {
              enable = true;
              create = "both";
              expunge = "imap";
              remove = "both";
              patterns = [ "*" ];
              extraConfig.channel.Sync = "All";
            };
            msmtp = {
              enable = true;
              extraConfig = { };
            };
            mu.enable = true;
          }
          cfg.email
        ];
        local.maildir.path = "local";
      };
    };

    vonfry.development.emacs.excludeModules = optionals (cfg.email == null) [ "tools/mail" ];

    warnings = mkMerge [ (genEmacsModuleWarning "tools/mail") ];

    home = {
      packages = with pkgs; [
        curl
        rsync
      ];

      shellAliases = {
        aria2-server = "aria2c --enable-rpc --rpc-allow-origin-all";
        dl = "aria2c";
      };
    };

    programs = {
      mbsync.enable = true;
      mu.enable = true;
      msmtp.enable = true;
      aria2.enable = true;
    };

    xdg = {
      mimeApps.defaultApplications = mkMerge [
        (mkIf whether_emacsclient_email {
          "x-scheme-handler/mailto" = "emacsclient-mail.desktop";
        })
      ];
    };
  };

  xcfg = {
    xdg.configFile = {
      "nyxt" = {
        source = ./files/nyxt;
        recursive = true;
      };
    };
    home = {
      sessionVariables = {
        BROWSER = "nyxt";
      };

      packages = with pkgs; [
        # tor-browser-bundle-bin
        firefox
        nyxt
      ];
    };
  };
in
{
  options.vonfry.net = {
    enable = mkEnableOption "Vonfry's network configurations.";
    email = mkOption {
      type = with types; nullOr attrs;
      description = "Private email config. This only for one account for myself. Other account should use original hm options.";
      default = null;
    };
  };

  config = mkMerge [
    { vonfry.net.enable = cfg'.enable; }
    (mkIf cfg.enable netcfg)
    (mkIf (cfg.enable && cfg'.x.enable) xcfg)
  ];
}
