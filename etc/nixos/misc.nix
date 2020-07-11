{ config, pkgs, ...}:

{
  fonts = {
    fonts = [
      pkgs.hack-font
      pkgs.source-han-sans-simplified-chinese
      pkgs.source-han-serif-simplified-chinese
      pkgs.symbola
      pkgs.liberation_ttf
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Source Han Sans CN" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Liberation Serif" "Source Han Serif CN" "Symbola" ];
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
