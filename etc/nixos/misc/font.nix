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
    ];
    fontconfig = {
      dpi = 80;
      enable = true;
      defaultFonts = {
        monospace = [ "Hack" "Fira Code" ];
        sansSerif = [ "Source Han Sans CN" ];
        serif = [ "Symbola"  ];
      };
    };
  };
}
