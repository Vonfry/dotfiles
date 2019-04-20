{ config, pkgs, lib, ... }:

{
  imports = let users = [ ./vonfry ]; in
    with import (dirOf <nixos-config> + /libs);
       lib.lists.flatten [users (matchFiles ./. "default\\.local\\.nix" [])];
}
