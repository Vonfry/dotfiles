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
}
