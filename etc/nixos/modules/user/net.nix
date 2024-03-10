{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.vonfry.net;
  cfg' = config.vonfry;

  whether_emacsclient_email = config.services.emacs.enable && cfg.email != null;
in {
  options.vonfry.net = {
    email = mkOption {
      type = with types; nullOr attrs;
      description = "Private email config.";
      default = null;
    };
  };

  config = mkIf cfg'.enable {
    accounts.email = mkIf (cfg.email != null) {
      maildirBasePath = "${config.home.homeDirectory}/.mail";
      accounts = {
        vonfry = mkMerge [{
          realName = "Vonfry";
          primary = true;
          # other configurations are save in local
          maildir.path = "mail";
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
            extraConfig = {
            };
          };
          mu.enable = true;
        } cfg.email];
        local.maildir.path = "local";
      };
    };

    vonfry.development.emacs.excludeModules =
      optionals (cfg.email == null) [ "misc/mail" "misc/feed" "misc/gnus"
                                      "misc/irc"
                                    ];
    warnings = optional (cfg.email == null) "email isn't set, so emacs module is disabled.";

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
        curl rsync

        firefox nyxt
        qbittorrent
        # tor-browser-bundle-bin

        iftop
      ];
    };

    programs = {
      mbsync.enable = true;
      mu.enable = true;
      msmtp.enable = true;
    };

    xdg = {
      mimeApps.defaultApplications = mkMerge [
        (mkIf whether_emacsclient_email {
          "x-scheme-handler/mailto" = "emacsclient-mail.desktop";
        })
      ];
    };
  };
}
