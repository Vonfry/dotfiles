{ config, pkgs, lib, ... }:

let
  inherit (import ./lib/prelude.nix { inherit lib; }) mkImportWith;
in {
  imports = mkImportWith ./local  [
    ./hardware-configuration.nix # use `nixos-generate-config`
    ./base.nix
    ./network.nix
    ./shell.nix
    ./development.nix
    ./x.nix
    ./application.nix
    ./misc.nix
    ./user
  ];

  lib = pkgs.callPackage ./lib { };
}
