{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
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
      stateVersion = "24.05";

      keyboard = {
        variant = "dvp";
        layout = "us";
      };

      packages = with pkgs; [
        sshfs exfat

        patch parallel file

        atop
        libarchive zstd convmv
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
        # TODO remove this if I use gpg to manage all ssh keys.
        addKeysToAgent = "yes";
      };
      btop = {
        enable = true;
        settings = {
          color_theme = "dracula";
          vim_keys = true;
          rounded_corners = true;
          graph_symbol = "braille";
          graph_symbol_cpu = "default";
          graph_symbol_mem = "default";
          graph_symbol_net = "default";
          graph_symbol_proc = "default";
          shown_boxes = "cpu mem net proc";
          update_ms = 2000;
          proc_sorting = "cpu lazy";
          proc_reversed = false;
          proc_tree = true;
          proc_colors = true;
          proc_gradient = true;
          proc_per_core = true;
          proc_mem_bytes = true;
          proc_info_smaps = false;
          proc_left = false;
          cpu_graph_upper = "total";
          cpu_graph_lower = "total";
          cpu_invert_lower = true;
          cpu_single_graph = false;
          cpu_bottom = false;
          show_uptime = true;
          check_temp = true;
          cpu_sensor = "Auto";
          show_coretemp = true;
          cpu_core_map = "";
          temp_scale = "celsius";
          show_cpu_freq = true;
          clock_format = "%X";
          background_update = true;
          custom_cpu_name = "";
          disks_filter = "";
          mem_graphs = true;
          mem_below_net = false;
          show_swap = true;
          swap_disk = true;
          show_disks = true;
          only_physical = true;
          use_fstab = true;
          show_io_stat = true;
          io_mode = true;
          io_graph_combined = true;
          io_graph_speeds = "";
          net_download = 100;
          net_upload = 100;
          net_auto = true;
          net_sync = false;
          net_iface = "";
          show_battery = true;
          selected_battery = "Auto";
          log_level = "WARNING";
        };
      };
    };
  };
}
