self: super:

let
  inherit (self) callPackage;
  sources = super.callPackage ./_sources/generated.nix { };
in {
  vonfryPackages = {
    rimePlugins = callPackage ./applications/rime-plugins { inherit sources; };

    iconFace = sources.vonfry-icon.src;

    fortuneChinese = callPackage ./data/fortune-chinese { inherit sources; };

    desktopBackground = sources.background-image.src;

    sddm-slice-theme = callPackage ./data/sddm-slice-theme { inherit sources; };

    fcitx5-theme = {
      material-color = sources.fcitx5-material-color.src;

      nord = sources.fcitx5-nord.src;
    };

    aria2Ng = callPackage ./tools/networking/aria2/aria2-ng.nix {
      inherit sources;
    };

  };
}
