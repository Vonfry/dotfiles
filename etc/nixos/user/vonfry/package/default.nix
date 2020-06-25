{ pkgs, lib, ... }:


let args = { pkgs = pkgs
           ; customPkgs = pkgs.callPackage ./custom {}
           ; lib = lib
           ; };
    localFiles = with builtins; with lib;
      map (n: ./local + "/${n}")
          (attrNames (filterAttrs
                     (n: v: v != "directory" && isList (match "^.*\\.nix$" n))
                     (readDir ./local)));
    importList = [ ./base.nix
                   ./misc.nix
                   ./editor.nix
                   ./shell.nix
                   ./net.nix
                   ./development.nix
                   ./media.nix
                 ] ++ localFiles;
in
{
  home.packages = builtins.foldl' (x: y: x ++ import y args) [] importList;
}
