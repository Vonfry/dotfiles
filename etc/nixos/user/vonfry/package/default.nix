{ pkgs, lib, ... }:

let args = { pkgs = pkgs
           ; customPkgs = pkgs.callPackage ./custom {}
           ; lib = lib;
           };
    importList = [ ./misc.nix
                   ./shell.nix
                   ./development
                   ./media.nix
                   ./local
                 ];
in builtins.foldl' (x: y: x ++ import y args) [] importList
