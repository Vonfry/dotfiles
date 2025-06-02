{
  lib,
  config,
  pkgs,
  ...
}:

let
  gamecfg = {
    programs.steam = {
      # There are some issues on update and other cases. Check the following
      # link for workrounds.
      # https://wiki.nixos.org/wiki/Steam#Steam_is_not_updated
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
in
{
  options.vonfry.game = {
    enable = lib.mkEnableOption "Vonfry's game configuration";
  };

  config = lib.mkMerge [
    { vonfry.game.enable = lib.mkDefault config.vonfry.workspace.home; }
    (lib.mkIf config.vonfry.game.enable gamecfg)
  ];
}
