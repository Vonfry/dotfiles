{ config, lib, ... }:

{
  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/.mail";
    accounts = {
      vonfry = {
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
      };
      local.maildir.path = "local";
    };
  };
  programs = {
    mbsync.enable = true;
  };
}
