{ pkgs, lib, ... }:

let args = { pkgs = pkgs
           ; customPkgs = pkgs.callPackage ./custom {}
           ; lib = lib
           ; };
    importList = [ ./base.nix
                   ./misc.nix
                   ./editor.nix
                   ./shell.nix
                   ./development.nix
                   ./media.nix
                   ./font.nix
                   ./local
                 ];
in builtins.foldl' (x: y: x ++ import y args) [] importList
