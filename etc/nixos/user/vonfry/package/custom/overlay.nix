self: super:

let inherit (super) callPackage;
    unstableNixos = import <nixos-unstable> {
        config = {
          allowUnfree = true;
        };
      };
in rec {
  unstable = unstableNixos;
  hie = callPackage ./development/haskell/hie { };
  fira-code-symbols = callPackage ./data/fonts/fira-code-symbols
                                  { fira-code = unstable.fira-code; };
}
