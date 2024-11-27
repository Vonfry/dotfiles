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
    programs.command-not-found.enable = false;

    # Let vendors work in hm.
    programs.fish.enable = true;

    console = {
      font = "ter-v12n";
      packages = with pkgs; [ terminus_font ];
    };
  };
}
