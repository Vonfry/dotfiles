{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    programs = {
      zsh.enable = true;
    };

    console = {
      font = "ter-v12n";
      packages = with pkgs; [ terminus_font ];
    };
  };
}
