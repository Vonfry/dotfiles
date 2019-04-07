{ pkgs, ... } @ args:

with import (dirOf <nixos-config> + /libs);
builtins.foldl' (x: y: x ++ import y args) [] [
  ./env.nix
  ./lang.nix
  ./net.nix
  ./db.nix ]
