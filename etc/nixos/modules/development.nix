{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git

      # bintools-unwrapped # for readelf objdump size nm
    ];

    virtualisation = {
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
      };
    };

    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = true; # this is needed by libvirt for nat
    };
  };
}
