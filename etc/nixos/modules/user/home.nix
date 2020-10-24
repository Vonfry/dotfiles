{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  options.vonfry = {
    enable = mkEnableOption "Vonfry configuration";
  };

  lib = pkgs.callPackage ./lib { };

  programs.home-manager.enable = true;

  imports = [
    ./base.nix
    ./development.nix
    ./net.nix
    ./shell.nix
    ./x.nix
    ./application.nix
    ./misc.nix
  ];
}
