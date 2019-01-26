{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix # use `nixos-generate-config` 
      ./vonfry
    ];

}
