{ config, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  options.vonfry = {
    secretsName.password = mkOption {
      description = "The sops key for password.";
      type = types.nonEmptyStr;
      default = "${config.users.users.vonfry.name}-password";
    };
  };
  config = mkIf cfg.enable {
    sops.secrets.${cfg.secretsName.password}.neededForUsers = true;
  };
}
