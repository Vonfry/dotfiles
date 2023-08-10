{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
  cfg' = config.vonfry.x;

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
in {
  options.vonfry.x.bgFile = mkOption {
    default = defaultBgFile;
    type = types.path;
    description = "The background file.";
  };

  config = mkIf cfg.enable {
    # QT is set by qt5ct manually and the qt5ct is configured in nixos module.
    # GTK needs dbus with dconf
    gtk = {
      enable = true;
      font = {
        name = "monospace";
      };
      theme = {
        name = "Breeze-Dark";
        package = pkgs.breeze-gtk;
      };
      iconTheme = {
        name = "breeze-dark";
        package = pkgs.breeze-icons;
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
      windowManager.command = ''test -n "$1" && eval "$@"'';

    };

    services = {
      dunst = {
        enable = true;
        iconTheme = {
          name = "breeze-dark";
          package = pkgs.breeze-icons;
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
            browser = "qutebrowser";
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
      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
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
        [ -h "${bgFile}" ] || ln -s ${cfg'.bgFile} ${bgFile}
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
        dragon
        recursive
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese
        font-awesome
        deployFcitx5Rime
      ];
    };
  };
}
