self: super:

let
  vPkgs = self.callPackage ./. {  };
  unstable = import <nixpkgs-unstable> {
    overlays = [];
    config = import ../files/nixpkgs.nix;
  };
in {
  inherit unstable;
  inherit (vPkgs) hie;
  vonfryPackages = vPkgs;
}
