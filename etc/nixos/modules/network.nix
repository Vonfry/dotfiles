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

    networking = {
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
