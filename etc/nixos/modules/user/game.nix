{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry.game;
in {
  options.vonfry.game = {
    enable = mkEnableOption "Vonfry's game configuration";
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [ osu-lazer-bin ];
    };
  };
}
