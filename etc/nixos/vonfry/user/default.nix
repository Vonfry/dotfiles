{ config, pkgs, ... }:

{
  imports = let users = [ ./vonfry.nix ]; in
    with import (<nixos-config> + "/../vonfry/libs");
       mergeList users (matchFiles ./. "[A-z0-9]*\\.local\\.nix" []);
}
