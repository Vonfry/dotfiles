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
      virtualbox.host.enable = true;
      docker = {
        enable = true;
        autoPrune.enable = true;
      };
    };

    documentation.dev.enable = true;
  };
}
