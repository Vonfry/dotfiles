{ config, pkgs, ... }:

let 
  lib = import <nixos-vonfry-lib>;
  inherit (lib) matchFiles;
in
{
  imports = matchFiles ./. ".*\\.nix" [ ./default.nix ];
}
