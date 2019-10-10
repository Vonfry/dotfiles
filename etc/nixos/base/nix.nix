{ config, pkgs, ... }:

{
  nix.trustedUsers = [ "root" "@wheel" ];
}
