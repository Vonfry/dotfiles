{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry.x;


  # Remove ly relatived config after github:nixos/nixpkgs#297234 is merged.
  dmcfg = config.services.xserver.displayManager;
  xEnv = config.systemd.services.display-manager.environment;

  ly = pkgs.ly.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "fairyglade";
      repo = "ly";
      rev = "4ee2b3ecc73882cfecdbe2162d4fece406a110e7";
      hash = "sha256-puv8QCM6Vt/9WmJd9CLQIhVl7r1aVO64zopIrgMPGhw=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];

    postFixup = ''
      wrapProgram $out/bin/ly --prefix PATH : ${makeBinPath [pkgs.ncurses]}
    '';
  };

  iniFmt = pkgs.formats.iniWithGlobalSection { };

  xserverWrapper = pkgs.writeShellScript "xserver-wrapper" ''
    ${concatMapStrings (n: "export ${n}=\"${getAttr n xEnv}\"\n") (attrNames xEnv)}
    exec systemd-cat -t xserver-wrapper ${dmcfg.xserverBin} ${toString dmcfg.xserverArgs} "$@"
  '';
  ly-data-wrapper = pkgs.linkFarm "ly-data-wrapper" {
    "bin/xauth" = "${pkgs.xorg.xauth}/bin/xauth";
    "bin/ly-xserver" = xserverWrapper;
    "share/ly" = "${dmcfg.sessionData.desktops}/share";
    "bin/ly-session" = dmcfg.sessionData.wrapper;
  };

  lyConfig = {
      shutdown_cmd = "/run/current-system/systemd/bin/systemctl poweroff";
      restart_cmd = "/run/current-system/systemd/bin/systemctl reboot";
      tty = 2;
      service_name = "ly";
      path = "/run/current-system/sw/bin";
      term_reset_cmd = "tput reset";
      mcookie_cmd = "/run/current-system/sw/bin/mcookie";
      waylandsessions = "/run/current-system/sw/share/ly/wayland-sessions";
      wayland_cmd = "/run/current-system/sw/bin/ly-session";
      xsessions = "/run/current-system/sw/share/ly/xsessions";
      xauth_cmd = "/run/current-system/sw/bin/xauth";
      x_cmd = "/run/current-system/sw/bin/ly-xserver";
      x_cmd_setup = "/run/current-system/sw/bin/ly-session";
  };

  lyCfgFile = iniFmt.generate "config.ini" { globalSection = lyConfig; };

  xconfig = {
    environment.systemPackages = (with pkgs; [
      xclip
      alacritty
      libnotify
    ]) ++ [ ly ly-data-wrapper ];

    environment.etc."ly/config.ini".source = lyCfgFile;
    environment.pathsToLink = [ "/share/ly" ];
    security.pam.services.ly = {
      startSession = true;
      unixAuth = true;
    };

    services.xbanish.enable = true;


    services.dbus.packages = [ ly ];
    services.xserver = {
      enable = true;
      displayManager.job.execCmd = "exec /run/current-system/sw/bin/ly";
      # To enable user switching, allow ly to allocate TTYs/displays dynamically.
      tty = null;
      display = null;
      xkb = {
        layout = "us";
        variant = mkDefault "dvp";
      };
      autorun = mkDefault true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };

      desktopManager.runXdgAutostartIfNone = true;

      displayManager= {
        lightdm.enable = false;
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
      weylus = {
        enable = true;
        openFirewall = true;
        users = [ "vonfry" ];
      };
    };

    systemd = {
      services.display-manager = {
        enable = true;
        after = [
          "systemd-user-sessions.service"
          "plymouth-quit-wait.service"
          "getty@tty${toString lyConfig.tty}.service"
        ];

        conflicts = [
          "getty@tty7.service"
        ];

        serviceConfig = {
          Type = "idle";
          StandardInput = "tty";
          TTYPath = "/dev/tty${toString lyConfig.tty}";
          TTYReset = "yes";
          TTYHangup = "yes";
        };
      };
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime ];
    };

    fonts = {
      packages = with pkgs; [
        recursive
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese

        font-awesome
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
in {
  options.vonfry.x = {
    enable = mkEnableOption "xserver.";
  };

  config = mkMerge [
    { vonfry.x.enable = mkDefault (!config.vonfry.workspace.server); }
    (mkIf cfg.enable xconfig)
  ];
}
