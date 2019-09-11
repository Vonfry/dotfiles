args@{ pkgs, lib, ... }:

let nixFiles = lib.matchFiles ./. "^.*\\.nix$" [ "default.nix" ];
in map (f: import f args) nixFiles
