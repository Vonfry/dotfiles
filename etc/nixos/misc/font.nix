{ config, pkgs, ...}:

{
  fonts = {
    fonts = [
      pkgs.hack-font
      pkgs.source-han-sans-simplified-chinese
      pkgs.symbola
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code Symbols" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Symbola"  ];
      };
    };
  };
}
