{ config, pkgs, lib, ... }:

{
  imports = lib.nixFiles ./.;
  environment.systemPackages = with pkgs;
    [ nmap
      vnstat
      iftop
      wireshark
    ];
}
