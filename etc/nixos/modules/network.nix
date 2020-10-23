{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
  cfgSsh = config.services.openssh;

  enableTCP22 = cfgSsh.enable && cfgSsh.listenAddresses == [ ];
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wget curl w3m

      vnstat iftop
      wireshark nmap
    ];

    networking = {
      firewall = {
        enable = mkDefault true;
        allowedTCPPorts = optional enableTCP22 22;
        allowedTCPPortRanges = [ ];
        allowedUDPPorts = [ ];
        allowPing = mkDefault false;
        extraPackages = with pkgs; [ ipset ];
      };
      networkmanager.enable = true;
    };
  };
}
