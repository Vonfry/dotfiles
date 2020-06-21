{ config, pkgs, ... }:

{
  imports = nixlFiles ./.;
  environment.systemPackages = with pkgs;
    [ nmap
      vnstat
      iftop
      wireshark
    ];
}
