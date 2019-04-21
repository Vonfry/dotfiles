{ config, pkgs, lib, ... }:

{
  imports = let users = [ ./vonfry ]; in
    with import <nixos-vonfry-lib>;
       lib.lists.flatten [users (matchFiles ./. "default\\.local\\.nix" [])];
}
