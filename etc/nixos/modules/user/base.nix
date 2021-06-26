{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;

  inherit (config.xdg) configHome;

  overlayPath = ../overlay/overlays.nix;
in {
  config = mkIf cfg.enable {
    xdg.configFile = {
      "nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        keep-derivations = true
        max-jobs = auto
        cores = 0
      '';
      "nixpkgs/config.nix".source = ./files/nixpkgs.nix;
    };

    home = {
      username = "vonfry";
      homeDirectory = "/home/vonfry";
      stateVersion = "21.05";

      keyboard = {
        variant = "dvp";
        layout = "us";
      };

      activation.nixpkgsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${toString overlayPath} ${toString configHome}/nixpkgs/overlays.nix
      '';

      packages = with pkgs; [
        sshfs exfat

        patch parallel file

        unar convmv
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
      htop = {
        enable = true;
        settings = with config.lib.htop; {
          tree_view = 1;
          highlight_base_name = 1;
          show_program_path = 0;
          vim_mode = 1;
          shadow_other_users = 1;
          hide_userland_threads = 1;
          hide_threads = 1;
          fields = with fields; [
            PID USER PRIORITY NICE M_SIZE M_RESIDENT M_SHARE STATE PERCENT_CPU
            PERCENT_MEM IO_READ_RATE IO_WRITE_RATE TIME COMM
          ];
          left_meters = [ "AllCPUs" "Memory" "Swap" ];
          left_meter_modes = lib.genList (_: modes.Text) 3;
          right_meters = [ "Clock" "Battery" "Blank" "Tasks" "Uptime"
                           "LoadAverage" "Blank" "PressureStallCPUSome"
                           "PressureStallIOSome" "PressureStallMemorySome"
                         ];
          right_meter_modes = lib.genList (_: modes.Text) 10;
        };
      };
    };
  };
}
