args@{ pkgs, lib, ... }:

let files = lib.nixFiles' ./.;
in builtins.foldl' (p: f: p ++ import f args) [] files
