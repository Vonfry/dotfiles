{ pkgs, ... } @ args:

builtins.foldl' (x: y: x ++ import y args) [] [
  ./env.nix
  ./lang.nix
  ./net.nix
  ./db.nix ]
