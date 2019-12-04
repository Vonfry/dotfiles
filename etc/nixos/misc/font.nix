{ config, pkgs, ...}:

{
  fonts = {
    fonts = with pkgs; [
      hack-font
      source-han-sans-simplified-chinese
      fira-code
      symbola
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Symbola"  ];
      };
    };
  };
}
