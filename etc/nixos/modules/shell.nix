{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    programs.command-not-found.enable = false;

    console = {
      font = "ter-v12n";
      packages = with pkgs; [ terminus_font ];
    };
  };
}
