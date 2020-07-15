self: super:

let
  vPkgs = self.callPackage ./. {  };
  unstable = import <nixpkgs-unstable> { overlays = []; };
in {
  inherit unstable;
  vonfryPackages = vPkgs;
}
