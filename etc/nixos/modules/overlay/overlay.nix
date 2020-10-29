self: super:

let
  vPkgs = self.callPackage ./. {  };
  unstable = import <nixpkgs-unstable> {
    overlays = [];
    config = import ../user/files/nixpkgs.nix;
  };
in {
  inherit unstable;
  vonfryPackages = vPkgs;
}
