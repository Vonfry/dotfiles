{ config, lib, pkgs, ... }:

{
  imports = [ ./base.local.nix ];

  nixpkgs = {
    config = import ./files/nixpkgs.nix;
    overlays = import ./overlay/overlays.nix;
  };

  home = {
    stateVersion = "20.09";

    file = {
      ".config/nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        sandbox = false
      '';
      ".config/nixpkgs/config.nix".source = ./files/nixpkgs.nix;
    };

    # home.activation can not help me to boot the ln process for home.nix becasue
    # if the script can be done, the home.nix has been linked.
    activation = {
      nixpkgsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${toString ./overlay/overlays.nix} ~/.config/nixpkgs/overlays.nix
      '';
    };

    packages = with pkgs; lib.optionals stdenv.isLinux [ lnav exfat ];
  };
}
