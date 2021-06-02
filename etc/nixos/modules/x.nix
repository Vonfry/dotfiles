{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry.x;

  screenlocker = pkgs.writeScriptBin "screenlocker" ''
    #!${pkgs.bash}/bin/bash -e
    exec ${pkgs.i3lock-color}/bin/i3lock-color -c 282a36 --indicator -k -B 1 --insidecolor=282a36 --insidewrongcolor=282a36 --insidevercolor=282a36 --ringvercolor=bd93f9 --ringwrongcolor=ff79c6 --ringcolor=44475a --linecolor=6272a4 --keyhlcolor=f1fa8c --bshlcolor=ff5555 --verifcolor=bd93f9 --wrongcolor=ff79c6 --timecolor=f8f8f2 --datecolor=6272a4 "$@"
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
      dunst libnotify
      vonfryPackages.chili-theme
      breeze-icons breeze-gtk breeze-qt5
      screenlocker
    ];

    services.xbanish.enable = true;

    services.dbus.packages = with pkgs; [ gnome3.dconf ];

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = mkDefault "dvp";
      autorun = mkDefault true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };

      displayManager= {
        sddm = {
          enable = true;
          theme = "chili";
        };
      };
      windowManager = {
        xmonad = {
          enable = mkDefault true;
          enableContribAndExtras = true;
        };
      };
    };

    services.xserver.displayManager.job.environment =
      let
        qtPkgs = with pkgs.libsForQt5; [ qtbase qtquickcontrols qtgraphicaleffects ];
        qtVersion = pkgs.qt5.qtbase.version;
        generateQml = concatMapStringsSep ":" (p: "${p.out}/lib/qt-${qtVersion}/qml") qtPkgs;
        generatePlugins = concatMapStringsSep ":" (p: "${p.out}/lib/qt-${qtVersion}/plugins") qtPkgs;
      in {
        QT_PLUGIN_PATH = "${generatePlugins}:/run/current-system/sw/${pkgs.qt5.qtbase.qtPluginPrefix}";
        QML2_IMPORT_PATH = "${generateQml}:/run/current-system/sw/${pkgs.qt5.qtbase.qtQmlPrefix}";
      };

    programs = {
      xss-lock = {
        enable = true;
        lockerCommand = "${lockCommand} -n";
      };
      qt5ct.enable = true;
    };

    systemd = {
      # Make screen locker in system due to security consider.
      user.services = {
        xidlehook = {
          enable = mkDefault true;
          description = "auto lock screen.";
          partOf = [ "graphical-session.target" ];
          script = ''
          ${pkgs.xidlehook}/bin/xidlehook \
            --timer ${toString cfg.durationLock}  "${lockCommand} || true" "" \
            --timer ${toString cfg.durationSuspend} "systemctl suspend" ""
        '';
          wantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}
