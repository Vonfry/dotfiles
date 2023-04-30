{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry.x;

  screenlocker = pkgs.writeScriptBin "screenlocker" ''
    #!${pkgs.bash}/bin/bash -e
    exec ${pkgs.i3lock-color}/bin/i3lock-color -c 282a36 --indicator -k -B 1 --inside-color=282a36 --insidewrong-color=282a36 --insidever-color=282a36 --ringver-color=bd93f9 --ringwrong-color=ff79c6 --ring-color=44475a --line-color=6272a4 --keyhl-color=f1fa8c --bshl-color=ff5555 --verif-color=bd93f9 --wrong-color=ff79c6 --time-color=f8f8f2 --date-color=6272a4 "$@"
  '';

  lockCommand = "${screenlocker}/bin/screenlocker";
in {
  options.vonfry.x = {
    durationLock = mkOption {
      default = 600;
      type = types.int;
      description = "The no activation duration before system lock. unit: second.";
    };

    durationSuspend = mkOption {
      default = 1800;
      type = types.int;
      description = "The no activation duration before system suspending. unit: second.";
    };
  };

  config = mkIf config.vonfry.enable {
    environment.systemPackages = with pkgs; [
      xclip
      alacritty
      libnotify
      vonfryPackages.sddm-slice-theme
      breeze-icons breeze-gtk breeze-qt5
      screenlocker

      # need by sddm theme in path
      libsForQt5.qtgraphicaleffects
    ];

    services.xbanish.enable = true;

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = mkDefault "dvp";
      autorun = mkDefault true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };

      desktopManager.runXdgAutostartIfNone = true;

      displayManager= {
        sddm = {
          enable = true;
          theme = "slice";
        };
      };
      windowManager = {
        xmonad = {
          enable = mkDefault true;
          enableContribAndExtras = true;
        };
      };
    };

    programs = {
      dconf.enable = true;
      xss-lock = {
        enable = true;
        lockerCommand = "${lockCommand} -n";
      };
      weylus = {
        enable = true;
        openFirewall = true;
        users = [ "vonfry" ];
      };
    };

    qt5 = {
      enable = true;
      platformTheme = "qt5ct";
    };

    hardware.uinput.enable = true;

    systemd = {
      # Make screen locker in system due to security consider.
      user.services = {
        xidlehook = {
          enable = mkDefault true;
          description = "auto lock screen.";
          partOf = [ "graphical-session.target" ];
          script = ''
          ${pkgs.xidlehook}/bin/xidlehook \
            --timer ${toString cfg.durationSuspend} "systemctl suspend" ""
        '';
          wantedBy = [ "graphical-session.target" ];
        };
      };
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime ];
    };

    fonts = {
      fonts = with pkgs; [
        recursive
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese

        font-awesome
        # need for sddm
        roboto
      ];
      fontconfig = {
        enable = true;
        # config this by your self, it is depended on which screen you
        # are using. It is suggested as a multiple of 6 or 12.
        # dpi = 96;
        defaultFonts = {
          monospace = [ "Rec Mono Casual" "Sarasa Mono SC" "Font Awesome 5 Free" ];
          sansSerif = [ "Recursive Sans Casual Static" "Liberation Sans" "Soruce Han Sans SC" "Font Awesome 5 Free" ];
          serif = [ "Liberation Serif" "Source Han Serif SC" "Symbola" "Font Awesome 5 Free" ];
        };
      };
    };

  };
}
