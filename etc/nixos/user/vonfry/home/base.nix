{ config, lib, ... }:

{
  imports = [ ./base.local.nix ];
  nixpkgs = {
    config = import ./files/nixpkgs.nix;
    overlays = import ../package/custom/overlays.nix;
  };
  home.file = {
    ".config/nix/nix.conf".text = ''
      auto-optimise-store = true
      keep-outputs = true
      sandbox = false
    '';
    ".config/nixpkgs/config.nix".source = ./files/nixpkgs.nix;
  };

  # home.activation can not help me to boot the ln process for home.nix becasue
  # if the script can be done, the home.nix has been linked.
  home.activation = {
    nixpkgsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${toString ../package/custom/overlays.nix} ~/.config/nixpkgs/overlays.nix
    '';
  };
}
