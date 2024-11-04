{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  gamecfg = {
    home = {
      packages = with pkgs; [ osu-lazer-bin ];
    };
  };
in
{
  options.vonfry.game = {
    enable = mkEnableOption "Vonfry's game configuration";
  };

  config = mkMerge [
    { vonfry.game.enable = mkDefault config.vonfry.workspace.home; }
    (mkIf config.vonfry.game.enable gamecfg)
  ];
}
