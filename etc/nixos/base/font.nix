{ config, pkgs, ...}:

{
  fonts = {
    fonts = with pkgs; [
      hack-font
      source-han-sans-simplified-chinese
      symbola
      fira-code-symbols
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code Symbol" ];
	    sansSerif = [ "Source Han Sans CN" ];
	    serif = [ "Symbola"  ];
      };
    };
  };
}
