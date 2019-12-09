{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = {
          allowUnfree = true;
        };
      };
      vonfryPackages = pkgs.callPackage ../user/vonfry/package/custom {  };
    };
  };
}
