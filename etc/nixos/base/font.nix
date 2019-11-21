{ config, pkgs, ...}:

{
  fonts = {
    fonts = with pkgs; [
      hack-font
      source-han-sans-simplified-chinese
      fira-code-symbols
      xits-math
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code Symbol" ];
	    sansSerif = [ "Source Han Sans CN" ];
	    serif = [ "XITS Math"  ];
      };
    };
  };
}
