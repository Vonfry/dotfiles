{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix # use `nixos-generate-config`
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
