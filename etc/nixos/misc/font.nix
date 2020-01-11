{ config, pkgs, ...}:


let vonfryCustom = pkgs.callPackages (import ../user/vonfry/package/custom) {};
    fira-code-symbols = vonfryCustom.fira-code-symbols;
in {
  fonts = {
    fonts = [
      pkgs.hack-font
      pkgs.source-han-sans-simplified-chinese
      fira-code-symbols
      pkgs.source-han-serif-simplified-chinese
      pkgs.symbola
      pkgs.liberation_ttf
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code" "Source Han Sans CN" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Liberation Serif" "Source Han Serif CN" "Symbola" ];
      };
    };
  };
}
