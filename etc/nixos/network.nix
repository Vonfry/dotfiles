{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl w3m

    vnstat iftop
    wireshark nmap
  ];

  networking.networkmanager.enable = true;
}
