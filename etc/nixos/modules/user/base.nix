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
      "btop/btop.conf".text = ''
        color_theme = "${pkgs.btop}/share/btop/themes/dracula.theme"
        vim_keys = True
        rounded_corners = True
        graph_symbol = "braille"
        graph_symbol_cpu = "default"
        graph_symbol_mem = "default"
        graph_symbol_net = "default"
        graph_symbol_proc = "default"
        shown_boxes = "cpu mem net proc"
        update_ms = 2000
        proc_sorting = "cpu lazy"
        proc_reversed = False
        proc_tree = True
        proc_colors = True
        proc_gradient = True
        proc_per_core = True
        proc_mem_bytes = True
        proc_info_smaps = False
        proc_left = False
        cpu_graph_upper = "total"
        cpu_graph_lower = "total"
        cpu_invert_lower = True
        cpu_single_graph = False
        cpu_bottom = False
        show_uptime = True
        check_temp = True
        cpu_sensor = "Auto"
        show_coretemp = True
        cpu_core_map = ""
        temp_scale = "celsius"
        show_cpu_freq = True
        clock_format = "%X"
        background_update = True
        custom_cpu_name = ""
        disks_filter = ""
        mem_graphs = True
        mem_below_net = False
        show_swap = True
        swap_disk = True
        show_disks = True
        only_physical = True
        use_fstab = True
        show_io_stat = True
        io_mode = True
        io_graph_combined = True
        io_graph_speeds = ""
        net_download = 100
        net_upload = 100
        net_auto = True
        net_sync = False
        net_iface = ""
        show_battery = True
        selected_battery = "Auto"
        log_level = "WARNING"
      '';
    };

    home = {
      username = "vonfry";
      homeDirectory = "/home/vonfry";
      stateVersion = "22.11";

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
