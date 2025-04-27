{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry;

in
{
  config = mkIf cfg.enable {

    programs = {
      bash = {
        enable = true; # make some script can load hm-sessions.
      };
    };

    xdg.dataFile = {
      "fortunes" = {
        source =
          with pkgs;
          symlinkJoin {
            name = "fortunes";
            paths = [ "${vonfryPackages.fortuneChinese}/share/fortunes" ];
          };
        recursive = true;
      };
    };

    home = {
      sessionPath = [ "~/.local/bin" ];
    };
  };
}
