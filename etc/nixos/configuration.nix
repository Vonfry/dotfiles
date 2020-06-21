{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix # use `nixos-generate-config`
      ./lib
      ./base
      ./network
      ./shell
      ./editor
      ./development
      ./user
      ./misc
      ./x
      ./local
    ];
}
