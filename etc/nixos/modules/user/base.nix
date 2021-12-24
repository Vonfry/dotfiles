{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;

  inherit (config.xdg) configHome;
in {
  config = mkIf cfg.enable {
    xdg.configFile = {
      "nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        keep-derivations = true
      '';
      "nixpkgs/config.nix".source = ./files/nixpkgs.nix;
    };

    home = {
      username = "vonfry";
      homeDirectory = "/home/vonfry";
      stateVersion = "21.11";

      keyboard = {
        variant = "dvp";
        layout = "us";
      };

      packages = with pkgs; [
        sshfs exfat

        patch parallel file

        btop atop
        zstd archiver convmv
        colordiff
        ripgrep fd
      ];
    };

    programs = {
      man.enable = true;
      lsd = {
        enable = true;
        enableAliases = true;
        settings = {
          sorting = { dir-grouping = "first"; };
        };
      };
      ssh = {
        enable = true;
        compression = true;
        forwardAgent = true;
        serverAliveInterval = 60;
      };
    };
  };
}
