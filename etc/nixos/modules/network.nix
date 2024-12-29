{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ curl ];

    systemd.network.enable = true;

    networking = {
      useNetworkd = mkDefault true;
      firewall = {
        enable = mkDefault true;
        allowedTCPPorts = [ ];
        allowedTCPPortRanges = [ ];
        allowedUDPPorts = [ ];
        allowPing = mkDefault false;
        extraPackages = with pkgs; [ ];
      };
    };
  };
}
