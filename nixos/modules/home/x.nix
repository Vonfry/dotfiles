{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry.x;
  cfg' = config.vonfry;

  deployFcitx5Rime =
    with pkgs;
    writeScriptBin "fcitx5-rime-deploy" ''
      #!/usr/bin/env bash
      dbus-send --dest='org.fcitx.Fcitx5' \
                  --type=method_call \
                  '/controller' \
                  'org.fcitx.Fcitx.Controller1.SetConfig' \
                  string:"fcitx://config/addon/rime/deploy" \
                  variant:string:""
    '';

  screenlocker = pkgs.writeScriptBin "screenlocker" ''
    #!${pkgs.bash}/bin/bash -e
    exec ${pkgs.i3lock-color}/bin/i3lock-color -c 282a36 --indicator -k -B 1 --inside-color=282a36 --insidewrong-color=282a36 --insidever-color=282a36 --ringver-color=bd93f9 --ringwrong-color=ff79c6 --ring-color=44475a --line-color=6272a4 --keyhl-color=f1fa8c --bshl-color=ff5555 --verif-color=bd93f9 --wrong-color=ff79c6 --time-color=f8f8f2 --date-color=6272a4 "$@"
  '';

  lockCmd = "${screenlocker}/bin/screenlocker";

  xmonad-dir = ./files/xmonad;
  xmonad-main = xmonad-dir + "/xmonad.hs";
  xmonad-libdir = xmonad-dir + "/lib";
  genAttrSet =
    pathPrefix: dirPath:
    foldlAttrs (
      acc: name: type:
      let
        curPathname = "${pathPrefix}${name}";
        curPath = xmonad-libdir + "/${pathPrefix}${name}";
      in
      if type == "directory" then
        acc // genAttrSet "${curPathname}/" curPath
      else
        acc // { "${curPathname}" = curPath; }
    ) { } (builtins.readDir dirPath);
  xmonad-libFiles = genAttrSet "" xmonad-libdir;

  xcfg = {
    qt = {
      enable = true;
      style = {
        package = [
          pkgs.libsForQt5.qtstyleplugin-kvantum
          pkgs.qt6Packages.qtstyleplugin-kvantum
        ];
        name = "kvantum";
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
        name = "candy-icons";
        package = pkgs.candy-icons;
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

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = [ pkgs.vonfryPackages.fcitx5-rime ];
    };

    xsession = {
      enable = true;
      scriptPath = ".xinitrc";
      initExtra = ''
        ${pkgs.feh}/bin/feh --bg-center ${cfg.bgFile}
      '';
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          config = xmonad-main;
          libFiles = xmonad-libFiles;
        };
      };
    };

    services = {
      screen-locker = {
        enable = true;
        inherit lockCmd;
        xautolock.enable = false;
        xss-lock = { };
      };
      xidlehook = {
        enable = true;
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
          name = "candy-icons";
          package = pkgs.candy-icons;
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
            # browser = "nyxt";
            browser = "firefox";
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

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Rec Mono Casual"
          "Noto Sans Mono"
          "Noto Sans CJK SC"
          "Noto Sans Symbols"
          "Noto Sans Symbols 2"
        ];
        sansSerif = [
          "Recursive Sans Casual Static"
          "Noto Sans Display"
          "Noto Sans CJK SC"
          "Noto Sans Symbols"
          "Noto Sans Symbols 2"
        ];
        serif = [
          "Noto Serif Display"
          "Noto Sans CJK SC"
          "Noto Sans Symbols"
          "Noto Sans Symbols 2"
        ];
      };
    };

    xdg = {
      configFile = {
        "Kvantum/kvantum.kvconfig".text = ''
          theme=KvArcDark
        '';
      };
      dataFile = {
        "fcitx5/rime" = {
          source =
            with pkgs;
            with vonfryPackages.rimePlugins;
            runCommand "fcitx-rime-plugins" { } ''
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
      };
    };

    home = {
      pointerCursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        x11.enable = true;
        size = mkDefault 16;
      };

      packages = with pkgs; [
        vonfryPackages.fcitx5-theme.nord

        recursive
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        font-awesome

        deployFcitx5Rime

        screenlocker
      ];
    };

    # For xterm backend in special situations.
    xresources.properties = {
      "*.foreground" = "#F8F8F2";
      "*.background" = "#282A36";
      "*.color0" = "#000000";
      "*.color8" = "#4D4D4D";
      "*.color1" = "#FF5555";
      "*.color9" = "#FF6E67";
      "*.color2" = "#50FA7B";
      "*.color10" = "#5AF78E";
      "*.color3" = "#F1FA8C";
      "*.color11" = "#F4F99D";
      "*.color4" = "#BD93F9";
      "*.color12" = "#CAA9FA";
      "*.color5" = "#FF79C6";
      "*.color13" = "#FF92D0";
      "*.color6" = "#8BE9FD";
      "*.color14" = "#9AEDFE";
      "*.color7" = "#BFBFBF";
      "*.color15" = "#E6E6E6";
      "xterm*faceName" = "monospace";
      "xterm*faceSize" = "11";
    };
  };
in
{
  options.vonfry.x = {
    enable = mkEnableOption "Vonfry's x configurations.";

    bgFile = mkOption {
      default = pkgs.vonfryPackages.desktopBackground.outPath;
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
    (mkIf cfg.enable xcfg)
  ];
}
