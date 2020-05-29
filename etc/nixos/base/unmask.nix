{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };
  nixpkgs.overlays = import ../user/vonfry/package/custom/overlays.nix;
}
