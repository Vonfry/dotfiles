{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.vonfry;
in
{
  config = mkIf cfg.enable {
    lib = pkgs.callPackage ./lib { };
  };

  imports = [
    ./base.nix
    ./env.nix
    ./development.nix
    ./net.nix
    ./shell.nix
    ./x.nix
    ./application.nix
    ./misc.nix
    ./game.nix
    ./workspace.nix
  ];
}
