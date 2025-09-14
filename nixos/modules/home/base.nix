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
    nix.settings = {
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;

    };
    nix.gc = {
      automatic = mkDefault (!config.submoduleSupport.enable && !config.programs.nh.clean.enable);
      options = "--delete-older-than 14d";
      dates = "Sun 19:00";
    };

    nixpkgs = mkIf (!config.submoduleSupport.enable) {
      config = import ./files/nixpkgs.nix;
    };

    home = {
      username = "vonfry";
      homeDirectory = mkDefault "/home/vonfry";
      stateVersion = mkDefault "25.05";

      keyboard = {
        variant = "dvp";
        layout = "us";
      };

      file = {
        # make it auto cite
        ".parallel/will-cite".text = "";
      };

      packages = with pkgs; [
        patch
        parallel
        file

        ouch
        zstd
        ripgrep
        fd
      ];
    };

    programs = {
      man.enable = true;
      ssh = {
        enable = true;
        matchBlocks."*" = {
            compression = true;
            forwardAgent = true;
            serverAliveInterval = 60;
            serverAliveCountMax = 4;
        };
      };

      nh = mkMerge [
        {
          enable = true;
          clean = {
            enable = !config.submoduleSupport.enable;
            dates = "Sun 19:00";
            extraArgs = "--keep-since 14d --keep 5";
          };
        }
        (mkIf cfg.environment.dotfiles.enable {
          flake = "path:${cfg.environment.dotfiles.absolute_path}/nixos#nixosConfigurations.vonfry";
        })
      ];

      home-manager.enable = mkDefault (!config.programs.nh.enable);
    };
  };
}
