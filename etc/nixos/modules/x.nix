{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry.x;

  xconfig = {
    environment.systemPackages = with pkgs; [
      xclip
      alacritty
      libnotify
    ];

    services.xbanish.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd startx";
        };
      };
      vt = 2;
    };
    services.xserver = {
      enable = true;
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

      displayManager.startx.enable = true;
    };

    programs = {
      dconf.enable = true;
      weylus = {
        enable = true;
        openFirewall = true;
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
