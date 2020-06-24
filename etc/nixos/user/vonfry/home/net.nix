{ lib, ... }:

{
  accounts.email = {
    maildirBasePath = "\$HOME/.mail";
    accounts = {
      vonfry = {
        realName = "Vonfry";
        primary = true;
        # other configurations are save in local
        maildir = {
          path = "mail";
          mbsync = {
            enable = true;
            create = "both";
            expunge = true;
            remove = "both";
            patterns = [ "*" ];
            extraConfig.channel.Sync = "All";
          };
        };
      };
      local.maildir.path = "local";
    };
  };
}
