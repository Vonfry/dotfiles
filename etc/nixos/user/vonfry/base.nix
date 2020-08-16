{ config, lib, pkgs, ... }:

{
  imports = [ ./base.local.nix ];

  nixpkgs = {
    config = import ./files/nixpkgs.nix;
    overlays = import ./overlay/overlays.nix;
  };


  xdg.configFile = {
    "nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        sandbox = false
        max-jobs = auto
        cores = 0
      '';
    "nixpkgs/config.nix".source = ./files/nixpkgs.nix;
  };

  home = {
    stateVersion = "20.09";

    activation.ixpkgsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${toString ./overlay/overlays.nix} ${toString config.xdg.configHome}/nixpkgs/overlays.nix
    '';

    packages = with pkgs; [ lnav exfat ];
  };
}
