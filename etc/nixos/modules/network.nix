{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.vonfry.network;
in {
  config = mkIf config.vonfry.enable {
    environment.systemPackages = with pkgs; [ curl ];

    networking = {
      firewall = {
        enable = mkDefault true;
        allowedTCPPorts = [ ];
        allowedTCPPortRanges = [ ];
        allowedUDPPorts = [ ];
        allowPing = mkDefault false;
        extraPackages = with pkgs; [ ];
      };
      networkmanager = {
        enable = mkDefault true;
        dhcp = "internal";
      };
    };
  };
}
