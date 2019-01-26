{ config, pkgs, ... }:

{
  networking.hosts = {
    "127.0.0.1" = [ "nixos" ];
    "10.211.55.2" = [ "macOS" ];
  };
}
