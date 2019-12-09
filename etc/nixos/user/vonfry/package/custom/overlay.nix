self: super:

let inherit (super) callPackage;
    unstableNixos = import <nixos-unstable> {
        config = {
          allowUnfree = true;
        };
      };
in rec {
  unstable = unstableNixos;
  vonfryPackages = {
    hie = callPackage ./development/haskell/hie { };
    fira-code-symbols = callPackage ./data/fonts/fira-code-symbols
                                    { fira-code = unstable.fira-code; };
    python = callPackage ./development/python/python { python = python3; };
    rubyPkgs = callPackage ./development/ruby/self-pkgs { };
    xmonad = callPackage ./applications/window-managers/xmonad { };
  };
}
