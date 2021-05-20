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
      curl

      iftop
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
      networkmanager = {
        enable = mkDefault true;
        dhcp = "dhclient";
      };
    };

    services = {
      zerotierone = {
        enable = length cfg.zerotierNets != 0;
        joinNetworks = cfg.zerotierNets;
      };
    };
  };
}
