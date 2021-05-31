{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim neovim emacs

      git git-lfs
    ];

    virtualisation = {
      oic-containers.backend = "podman";

      libvirtd = {
        enable = true;
        qemuRunAsRoot = mkDefault false;
        qemuPackage = mkDefault pkgs.qemu_kvm;
      };

      podman = {
        enable = true;
      };
    };
  };
}
