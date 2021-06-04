{ unstable, pkgs }:

with pkgs;

{
  inherit unstable;

  rimePlugins = callPackage ./applications/rime-plugins { };

  icon-face = callPackage ./data/icon-face { };

  fortuneChinese = callPackage ./data/fortune-chinese { };

  desktopBackground = callPackage ./data/desktop-background { };

  sddm-chili-theme = callPackage ./data/sddm-chili-theme { };

  sddm-slice-theme = callPackage ./data/sddm-slice-theme { };

  fcitx5-theme = callPackage ./data/fcitx5-theme { };
}
