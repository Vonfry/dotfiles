{ config, pkgs, ... }:

let lib = import <nixos-vonfry-lib>; in
{
  imports = lib.matchFiles ./. "default\\.local\\.nix" [];
  users.users.vonfry.packages =
    let args = { pkgs = pkgs; customPkgs = pkgs.callPackage ./custom {}; };
        importList = [ ./misc.nix ./shell.nix ./dev ./media.nix ];
    in builtins.foldl' (x: y: x ++ import y args) [] importList;
}
