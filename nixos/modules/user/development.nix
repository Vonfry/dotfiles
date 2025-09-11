{ lib, config, ... }:

with lib;
let
  cfg = config.vonfry;
  vonfry = config.users.users.vonfry.name;
in
{
  config = mkIf cfg.enable {
    # FIXME Due to userborn's restriction, and this is needed by podman.
    environment.etc = {
      "subuid" = {
        text = ''
          ${vonfry}:100000:65536
        '';
        mode = "0444";
      };
      "subgid" = {
        text = ''
          ${vonfry}:100000:65536
        '';
        mode = "0444";
      };
    };
  };
}
