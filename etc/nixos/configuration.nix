{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix # use `nixos-generate-config`
      ./base
      ./network
      ./shell
      ./editor
      ./dev
      ./user
      ./misc
      ./x
      ./local
    ];
}
