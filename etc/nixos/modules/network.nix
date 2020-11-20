{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.vonfry.network;
in {
  options.vonfry.network = {
    zerotierNets = mkOption {
      default = [];
      type = with types; listOf str;
    };
  };

  config = mkIf config.vonfry.enable {
    environment.systemPackages = with pkgs; [
      wget curl w3m

      vnstat iftop
      wireshark nmap
    ];

    networking = {
      firewall = {
        enable = mkDefault true;
        allowedTCPPorts = [ ];
        allowedTCPPortRanges = [ ];
        allowedUDPPorts = [ ];
        allowPing = mkDefault false;
        extraPackages = with pkgs; [ ipset ];
      };
      networkmanager.enable = true;
    };

    services = {
      zerotierone = {
        enable = length cfg.zerotierNets != 0;
        joinNetworks = cfg.zerotierNets;
      };
    };
  };
}
