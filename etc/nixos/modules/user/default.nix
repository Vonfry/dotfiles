{ config, pkgs, lib, ... }:

let
  inherit (import ../lib/prelude.nix { inherit lib; }) mkImportWith;
in {
  users.motd = builtins.readFile ./motd;

  home-manager.useUserPackages = true;

  imports = mkImportWith ./local [
    ./vonfry
    <home-manager/nixos>
  ];
}
