{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry.x;
  chili-drv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/feijoas/nixpkgs/chili-sddm-theme/pkgs/data/themes/chili/chili.nix";
    sha256 = "0ib56hy9qqp187hyhgp361yvxqlffpplvw2w73j7mjzqdp49ms6k";
  };
  qtVersion = pkgs."qt${cfg.sddmQtVersion}".qtbase.version;
in {
  options.vonfry.x = {
    sddmQtVersion = mkOption {
      # my sddm use this version
      default = "512";
      type = types.str;
      description = "sddm may use a different qt version from default one. So we set it.";
    };

    chiliPackage = mkOption {
      default = pkgs."libsForQt${cfg.sddmQtVersion}".callPackage chili-drv {};
      description = "sddm theme: chili package";
      type = types.package;
    };

    lockScript = mkOption {
      default = "${pkgs.i3lock-color}/bin/i3lock-color -n -c 282a36 --indicator -k -B 1 --insidecolor=282a36 --insidewrongcolor=282a36 --insidevercolor=282a36 --ringvercolor=bd93f9 --ringwrongcolor=ff79c6 --ringcolor=44475a --linecolor=6272a4 --keyhlcolor=f1fa8c --bshlcolor=ff5555 --verifcolor=bd93f9 --wrongcolor=ff79c6 --timecolor=f8f8f2 --datecolor=6272a4";
      type = types.str;
      description = "lock screen command.";
    };

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
      unstable.dracula-theme
      cfg.chiliPackage
      breeze-icons
    ];

    services.xbanish.enable = true;

    services.dbus.packages = with pkgs; [ gnome3.dconf ];

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = mkDefault "dvp";
      autorun = true;

      libinput = {
        enable = true;
        accelProfile = "flat";
      };

      displayManager= {
        setupCommands = ''
          # prevent garbage collection
          # ${toString chili-drv}
        '';
        sddm = {
          enable = true;
          theme = "chili";
        };
      };
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
    };

    services.xserver.displayManager.job.environment =
      let
        qtPkgs = cfg.chiliPackage.buildInputs;
        generateQml = concatMapStringsSep ":" (p: "${p.out}/lib/qt-${qtVersion}/qml") qtPkgs;
        generatePlugins = concatMapStringsSep ":" (p: "${p.out}/lib/qt-${qtVersion}/plugins") qtPkgs;
      in {
        QT_PLUGIN_PATH = "${generatePlugins}:/run/current-system/sw/${pkgs."qt${cfg.sddmQtVersion}".qtbase.qtPluginPrefix}";
        QML2_IMPORT_PATH = "${generateQml}:/run/current-system/sw/${pkgs."qt${cfg.sddmQtVersion}".qtbase.qtQmlPrefix}";
      };

    programs.xss-lock = {
      enable = true;
      lockerCommand = cfg.lockScript;
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
            --timer ${toString cfg.durationLock}  "${cfg.lockScript}" ""\
            --timer ${toString cfg.durationSuspend} "systemctl suspend" ""
        '';
          wantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}
