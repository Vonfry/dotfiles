{ config, pkgs, ... }:

{
  imports = let users = [ ./vonfry ]; in
    with import (dirOf <nixos-config> + /vonfry/libs);
       mergeList users (matchFiles ./. "[A-z0-9]*\\.local\\.nix" []);
}
