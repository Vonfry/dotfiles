self: super:

let
  unstable = import <nixpkgs-unstable> { overlays = []; };
  vPkgs = self.callPackage ./. { unstable = unstable; };
in {
  inherit unstable;
  vonfryPackages = vPkgs;
}
