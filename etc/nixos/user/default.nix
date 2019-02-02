{ config, pkgs, ... }:

{
  imports = let users = [ ./vonfry ]; in
    with import (dirOf <nixos-config> + /libs);
       mergeList users (matchFiles ./. "default\\.local\\.nix" []);
}
