{ pkgs, lib, ... }:

let
  inherit (import ./lib/prelude.nix { inherit lib; }) mkImportWith;
in {

  lib = pkgs.callPackage ./lib { };

  programs.home-manager.enable = true;

  imports = mkImportWith ./local [
    ./base.nix
    ./development.nix
    ./net.nix
    ./shell.nix
    ./x.nix
    ./application.nix
    ./misc.nix
  ];
}
