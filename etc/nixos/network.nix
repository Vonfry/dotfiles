{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nmap
    vnstat
    iftop
    wireshark
  ];
}
