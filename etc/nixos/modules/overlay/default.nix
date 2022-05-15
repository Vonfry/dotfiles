self: super:

let
  inherit (self) callPackage;
  sources = super.callPackage import ./_sources/generated.nix { };
in {
  vonfryPackages = {
    rimePlugins = callPackage ./applications/rime-plugins { inherit sources; };

    iconFace = sources.vonfry-icon;

    fortuneChinese = callPackage ./data/fortune { inherit sources; };

    desktopBackground = sources.background-image;

    sddm-chili-theme = callPackage ./data/sddm-chili-theme { inherit sources; };

    sddm-slice-theme = callPackage ./data/sddm-slice-theme { inherit sources; };

    fcitx5-theme = {
      material-color = sources.fcitx5-material-color;

      nord = sources.fcitx5-nord;
    };

    aria2Ng = callPackage ./tools/networking/aria2/aria2-ng.nix {
      inherit sources;
    };

  };
}
