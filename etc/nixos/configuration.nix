{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # use `nixos-generate-config`
    ./lib
    ./base.nix
    ./network.nix
    ./shell.nix
    ./editor.nix
    ./development.nix
    ./x.nix
    ./misc.nix
    ./user
    ./local
  ];
}
