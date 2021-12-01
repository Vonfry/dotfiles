{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim emacs

      git git-lfs

      # bintools-unwrapped # for readelf objdump size nm
    ];

    virtualisation = {
      oci-containers.backend = "podman";

      libvirtd = {
        enable = true;
        qemu = {
          runAsRoot = mkDefault false;
          package = mkDefault pkgs.qemu_kvm;
        };
      };

      podman = {
        enable = true;
      };
    };
    environment.sessionVariables = {
      MANPAGER = "nvim +Man!";
      PAGER = "nvim -R";
    };
  };
}
