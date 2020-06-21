{ config, pkgs, lib, ... }:

{
  nix.trustedUsers = [ "root" "@wheel" ];
}
