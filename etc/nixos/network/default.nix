{ config, pkgs, ... }:

{
  imports = with import <nixos-vonfry-lib>;
    matchFiles ./. "[A-z0-9\\-]*\\.local\\.nix$" [ ./default.nix ];
  environment.systemPackages = with pkgs;
    [ nmap
      vnstat
      iftop
      wireshark
    ];
}
