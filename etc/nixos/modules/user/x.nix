{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry.x;
  cfg' = config.vonfry;

  inherit (config.home) homeDirectory;

  bgFile = "${homeDirectory}/.background-image";

  defaultBgFile = pkgs.vonfryPackages.desktopBackground.outPath;

  deployFcitx5Rime = with pkgs; writeScriptBin "fcitx5-rime-deploy" ''
    #!/usr/bin/env bash
    dbus-send --dest='org.fcitx.Fcitx5' \
                --type=method_call \
                '/controller' \
                'org.fcitx.Fcitx.Controller1.SetConfig' \
                string:"fcitx://config/addon/rime/deploy" \
                variant:string:""
  '';

  fcitx5-rime-overlay = self: super: {
    fcitx5-rime = super.fcitx5-rime.override {
      rime-data = null;
      rimeDataPkgs = [
        (self.runCommand "rime-data-nullify" {} "mkdir -p $out/share/rime-data")
      ];
    };
  };

  screenlocker = pkgs.writeScriptBin "screenlocker" ''
    #!${pkgs.bash}/bin/bash -e
    exec ${pkgs.i3lock-color}/bin/i3lock-color -c 282a36 --indicator -k -B 1 --inside-color=282a36 --insidewrong-color=282a36 --insidever-color=282a36 --ringver-color=bd93f9 --ringwrong-color=ff79c6 --ring-color=44475a --line-color=6272a4 --keyhl-color=f1fa8c --bshl-color=ff5555 --verif-color=bd93f9 --wrong-color=ff79c6 --time-color=f8f8f2 --date-color=6272a4 "$@"
  '';

  lockCmd = "${screenlocker}/bin/screenlocker";

  # TODO use this instead of home.files after
  # github:nix-community/home-manager#5203 is merged
  xmonad-dir = ./files/xmonad;
  xmonad-main = xmonad-dir + "/xmonad.hs";
  xmonad-libdir = xmonad-dir + "/lib";
  genAttrSet = pathPrefix: dirPath:
    foldlAttrs (acc: name: type:
      let
        curPathname = "${pathPrefix}${name}";
        curPath = xmonad-libdir + "/${pathPrefix}${name}";
      in
      if type == "directory"
      then acc // genAttrSet "${curPathname}/" curPath
      else acc // { "${curPathname}" = curPath; }
    ) { } (builtins.readDir dirPath);
  xmonad-libFiles = genAttrSet "" xmonad-libdir ;

  xdgcfg = {
    xdg = {
      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
    };
  };

  xcfg = {
    nixpkgs.overlays = [ fcitx5-rime-overlay ];

    qt = {
      enable = true;
      platformTheme = "qtct";
      style = {
        package = [ ];
        name = "fusion";
      };
    };
    # GTK needs dbus with dconf
    gtk = {
      enable = true;
      font = {
        name = "monospace";
      };
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      iconTheme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      cursorTheme = {
        name = "Dracula-cursors";
        package = pkgs.dracula-theme;
      };
      gtk2.extraConfig = ''
        gtk-application-prefer-dark-theme = true
      '';
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    programs = {
      alacritty = {
        settings = import ./files/alacritty.nix;
        enable = true;
      };
    };

    xsession = {
      enable = true;
      scriptPath = ".xinitrc";
      initExtra = ''
        # A fix from nixos xsession wrapper to ensure graphical session started.
        /run/current-system/systemd/bin/systemctl --user start nixos-fake-graphical-session.target
        /run/current-system/systemd/bin/systemctl --user start xdg-autostart-if-no-desktop-manager.target
        ${pkgs.feh}/bin/feh --bg-center ${bgFile}
      '';
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
    };

    services = {
      screen-locker = {
        enable = true;
        inherit lockCmd;
        xautolock.enable = false;
        xss-lock = {};
      };
      xidlehook = {
        enable = true;
        not-when-audio = true;
        timers = [
          {
            delay = cfg.durationSuspend;
            command = "suspend";
          }
        ];
      };
      dunst = {
        enable = true;
        iconTheme = {
          name = "Dracula";
          package = pkgs.dracula-icon-theme;
        };

        settings = {
          global = {
            font = "monospace";
            markup = true;
            plain_text = false;
            format = "<b>%s</b>\\n%b";
            sort = false;
            indicate_hidden = true;
            alignment = "center";
            bounce_freq = 0;
            show_age_threshold = -1;
            word_wrap = true;
            ignore_newline = false;
            stack_duplicates = true;
            hide_duplicates_count = true;
            geometry = "300x50-15+49";
            shrink = false;
            transparency = 5;
            idle_threshold = 0;
            monitor = 0;
            follow = "none";
            sticky_history = true;
            history_length = 15;
            show_indicators = false;
            line_height = 3;
            separator_height = 2;
            padding = 6;
            horizontal_padding = 6;
            separator_color = "frame";
            startup_notification = false;
            browser = "nyxt";
            icon_position = "off";
            max_icon_size = 80;
            frame_width = 3;
            frame_color = "#8EC07C";
          };
          urgency_low = {
            frame_color = "#3B7C87";
            foreground = "#3B7C87";
            background = "#191311";
            timeout = 4;
          };
          urgency_normal = {
            frame_color = "#5B8234";
            foreground = "#5B8234";
            background = "#191311";
            timeout = 6;
          };
          urgency_critical = {
            frame_color = "#B7472A";
            foreground = "#B7472A";
            background = "#191311";
            timeout = 8;
          };
        };
      };
    };

    fonts.fontconfig.enable = true;

    xdg = {
      dataFile = {
        "fcitx5/rime" = {
          source = with pkgs; with vonfryPackages.rimePlugins;
            runCommand "fcitx-rime-plugins" {} ''
              mkdir -p $out
              cp ${./files/rime/default.custom.yaml} $out/default.custom.yaml
              cp ${./files/rime/wubi86_jidian.custom.yaml} $out/wubi86_jidian.custom.yaml
              cp ${prelude}/share/rime/default.yaml $out
              cp ${prelude}/share/rime/symbols.yaml $out
              cp ${prelude}/share/rime/punctuation.yaml $out
              cp ${prelude}/share/rime/key_bindings.yaml $out
              cp ${cangjie}/share/rime/cangjie5.*.yaml $out
              cp ${wubi86-jidian}/share/rime/numbers.*.yaml $out
              cp ${wubi86-jidian}/share/rime/wubi86_jidian*.yaml $out
              cp ${japanese}/share/rime/japanese.*.yaml $out

              sed -i '/.*lua_.*@.*/d' $out/wubi86_jidian*.schema.yaml
              sed -i '/.*terra_pinyin.*/d' $out/japanese*.schema.yaml
              sed -i '/.*stroke.*/d' $out/japanese*.schema.yaml
            '';
          recursive = true;
        };
        "fcitx5/themes/Material-Color/theme.conf".source = "${pkgs.vonfryPackages.fcitx5-theme.material-color}/theme-deepPurple.conf";
        "fcitx5/themes/nord-dark" = {
          source = "${pkgs.vonfryPackages.fcitx5-theme.nord}/Nord-Dark";
          recursive = true;
        };
      };
    };

    home = {
      activation.xActivation = lib.hm.dag.entryAfter
        [ "writeBoundary" "linkGeneration" ] ''
        [ -h "${bgFile}" ] || ln -s ${cfg.bgFile} ${bgFile}
      '';

      file = {
        ".xmonad" = {
          source = ./files/xmonad;
          recursive = true;
        };
      };

      pointerCursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        x11.enable = true;
        size = mkDefault 16;
      };

      packages = with pkgs; [
        recursive
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese
        font-awesome
        deployFcitx5Rime

        screenlocker
      ];
    };
  };
in {
  options.vonfry.x = {
    enable = mkEnableOption "Vonfry's x configurations.";

    bgFile = mkOption {
      default = defaultBgFile;
      type = types.path;
      description = "The background file.";
    };

    durationSuspend = mkOption {
      default = 1800;
      type = types.int;
      description = "The no activation duration before system suspending. unit: second.";
    };
  };

  config = mkMerge [
    { vonfry.x.enable = mkDefault (!cfg'.workspace.server); }
    xdgcfg
    (mkIf cfg.enable xcfg)
  ];
}
