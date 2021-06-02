{ config, lib, pkgs, ...}:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-table-extra fcitx5-rime fcitx5-mozc
                                   fcitx5-chinese-addons
                                 ];
    };

    services.xserver.displayManager.sessionCommands = "${config.i18n.inputMethod.package}/bin/fcitx5";

    console = {
      font = "ter-v12n";
      packages = with pkgs; [ terminus_font kbd ];
    };

    fonts = {
      fonts = with pkgs; [
        hack-font
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
          monospace = [ "Hack" "Sarasa Mono SC" ];
          sansSerif = [ "Liberation Sans" "Soruce Han Sans SC" ];
          serif = [ "Liberation Serif" "Source Han Serif SC" "Symbola" ];
        };
      };
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
