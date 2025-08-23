{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry;
in
{
  config = mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;

      oci-containers.backend = "podman";

      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
        dockerCompat = true;
        autoPrune = {
          enable = mkDefault cfg.workspace.home;
          dates = mkDefault "monthly";
          flags = mkDefault ["-f"];
        };
      };
    };
  };
}
