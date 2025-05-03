{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry.x;

  xconfig = {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    services.xbanish.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # This is a personal configuration, so only x is used. For public one
          # or person wants to use multiple WM, tuigreet or a custom script can
          # be here to launch per-user customized wayland or x client instead.
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd startx";
        };
      };
      vt = 2;
    };
    services.xserver = {
      enable = true;
      autorun = mkDefault true;

      displayManager.startx.enable = true;
    };

    services.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };

    programs = {
      dconf.enable = true;
      weylus = {
        enable = true;
        openFirewall = true;
      };
    };

    # HOLD It should be open manually.
    security.pam.services.i3lock-color.enable = true;
    security.pam.services.i3lock.enable = true;

    fonts = {
      packages = with pkgs; [
        recursive
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese
      ];
      fontconfig = {
        enable = true;
        # config this by your self, it is depended on which screen you
        # are using. It is suggested as a multiple of 6 or 12.
        # dpi = 96;
        defaultFonts = {
          monospace = [
            "Rec Mono Casual"
            "Sarasa Mono SC"
            "Font Awesome 5 Free"
          ];
          sansSerif = [
            "Recursive Sans Casual Static"
            "Liberation Sans"
            "Soruce Han Sans SC"
            "Font Awesome 5 Free"
          ];
          serif = [
            "Liberation Serif"
            "Source Han Serif SC"
            "Symbola"
            "Font Awesome 5 Free"
          ];
        };
      };
    };
  };
in
{
  options.vonfry.x = {
    enable = mkEnableOption "xserver.";
  };

  config = mkMerge [
    { vonfry.x.enable = mkDefault (!config.vonfry.workspace.server); }
    (mkIf cfg.enable xconfig)
  ];
}
