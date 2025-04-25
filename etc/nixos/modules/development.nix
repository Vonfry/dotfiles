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
    environment.systemPackages = with pkgs; [
      git

      # bintools-unwrapped # for readelf objdump size nm
    ];

    virtualisation = {
      containers.enable = true;

      oci-containers.backend = "podman";

      libvirtd = {
        enable = mkDefault (!cfg.workspace.server);
        qemu = {
          runAsRoot = mkDefault false;
          package = mkDefault pkgs.qemu_kvm;
        };
      };

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

    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = true; # this is needed by libvirt for nat
    };
  };
}
