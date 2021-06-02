{ unstable, pkgs }:

with pkgs;

{
  inherit unstable;

  rimePlugins = import ./data/rime-plugins {
    inherit pkgs;
  };

  iconFace = callPackage ./data/icon-face { };

  fortuneChinese = callPackage ./data/fortune-chinese { };

  desktopBackground = callPackage ./data/desktop-background { };

  chili-theme = callPackage ./data/chili-theme { };

  fcitx5-theme = callPackage ./data/fcitx5-theme { };
}
