self: super:

let
  inherit (self) callPackage;
  sources = super.callPackage ./_sources/generated.nix { };
in
{
  vonfryPackages = {
    rimePlugins = callPackage ./applications/rime-plugins { inherit sources; };

    iconFace = sources.vonfry-icon.src;

    fortuneChinese = callPackage ./data/fortune-chinese { inherit sources; };

    desktopBackground = sources.background-image.src;

    fcitx5-theme = callPackage ./data/fcitx5-theme { inherit sources; };

    fcitx5-rime = callPackage ./applications/fcitx5-rime.nix { };
  };

}
