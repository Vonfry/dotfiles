{ config, pkgs, ... }:

{ 
  networking.firewall = {
      enable = false;
      allowedTCPPorts = [];
      allowedTCPPortRanges = [];
      allowPing = [];
  };
}
