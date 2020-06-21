{ pkgs, ... } @ args:

builtins.foldl' (x: y: x ++ import y args) []
  [ ./lang.nix
    ./net.nix
    ./db.nix
  ]
