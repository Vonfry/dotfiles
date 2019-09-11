{ config, pkgs, ... }:

{
  imports = with import <nixos-vonfry-lib>;
    matchFiles ./. "[A-z0-9\\-]*\\.local\\.nix$" [ ./default.nix ];
}
