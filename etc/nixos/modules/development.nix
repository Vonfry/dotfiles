{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim neovim emacs

      cloc

      docker_compose # docker

      git git-lfs
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemuRunAsRoot = mkDefault false;
      };

      docker = {
        enable = true;
        autoPrune.enable = mkDefault true;
      };
    };

    documentation.dev.enable = true;
  };
}
