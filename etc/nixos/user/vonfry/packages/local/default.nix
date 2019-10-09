args@{ pkgs, lib, ... }:

let nixFiles = lib.matchFiles ./. "^.*\\.nix$" [ ./default.nix ];
in builtins.foldl' (p: f: p ++ import f args) [] nixFiles
