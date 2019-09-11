{ config, pkgs, ... }:

{
  imports = with import <nixos-vonfry-lib>;
    matchFiles ./. "^.*\\.nix$" [ ./default.nix ];
}
