{ config, pkgs, ...}:

{
  fonts = {
    fonts = with pkgs; [
      hack-font
      source-han-sans-simplified-chinese
      symbola
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Symbola"  ];
      };
    };
  };
}
