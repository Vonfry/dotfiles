{ config, pkgs, ...}:


let vonfryCustom = pkgs.callPackages (import ../user/vonfry/package/custom) {};
    fira-code-symbols = vonfryCustom.fira-code-symbols;
in {
  fonts = {
    fonts = [
      pkgs.hack-font
      pkgs.source-han-sans-simplified-chinese
      fira-code-symbols
      pkgs.symbola
      pkgs.noto-fonts-cjk
      pkgs.liberation_ttf
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Liberation Serif" "Noto Sans CJK SC" "Symbola" ];
      };
    };
  };
}
