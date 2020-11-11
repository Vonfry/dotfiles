{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    nixpkgs = {
      config = import ./files/nixpkgs.nix;
      overlays = import ../overlay/overlays.nix;
    };

    xdg.configFile = {
      "nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        keep-derivations = true
        sandbox = false
        max-jobs = auto
        cores = 0
      '';
      "nixpkgs/config.nix".source = ./files/nixpkgs.nix;
    };

    home = {
      username = "vonfry";
      homeDirectory = "/home/vonfry";
      stateVersion = "20.09";

      activation.nixpkgsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${toString ../overlay/overlays.nix} ${toString config.xdg.configHome}/nixpkgs/overlays.nix
      '';

      packages = with pkgs; [
        atop # htop
        sshfs exfat
        lnav lm_sensors lsof

        ranger
        patch parallel file

        zip unzip convmv unrar
        colordiff
        ripgrep fd exa # bat
      ];
    };

    programs = {
      man.enable = true;
      bat.enable = true;
      ssh = {
        enable = true;
        compression = true;
        forwardAgent = true;
        serverAliveInterval = 60;
      };
      htop = {
        enable = true;
        treeView = true;
        highlightBaseName = true;
        showProgramPath = false;
        vimMode = true;
        shadowOtherUsers = true;
        hideUserlandThreads = true;
        hideThreads = true;
        fields = [ "PID" "USER" "PRIORITY" "NICE" "M_SIZE" "M_RESIDENT" "M_SHARE"
                   "STATE" "PERCENT_CPU" "PERCENT_MEM" "IO_READ_RATE"
                   "IO_WRITE_RATE" "TIME" "COMM"
                 ];
        meters = {
          left = [
            { kind = "AllCPUs"; mode = 2; }
            "Blank"
            { kind = "Memory" ; mode = 2; }
            { kind = "Swap"   ; mode = 2; }
          ];
          right = [
            { kind = "Clock"   ; mode = 2; }
            { kind = "Battery" ; mode = 2; }
            "Blank"
            { kind = "Tasks"   ; mode = 2; }
            { kind = "Uptime"  ; mode = 2; }
            "LoadAverage"
            "Blank"
            { kind = "PressureStallCPUSome";    mode = 2; }
            { kind = "PressureStallIOSome";     mode = 2; }
            { kind = "PressureStallMemorySome"; mode = 2; }
          ];
        };
      };
    };
  };
}
