{ config, pkgs, ...}:

{
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.teamviewer.enable = true;

  fonts = {
    fonts = with pkgs; [ hack-font source-han-sans-simplified-chinese ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" ];
	sansSerif = [ "Source Han Sans CN" ];
	serif = [];
      };
    };
  };
}
