{ config, pkgs, ... }:

let lib = import <nixos-vonfry-lib>; in
{
  users.users.vonfry.packages =
    let args =
        { pkgs = pkgs;
          customPkgs = pkgs.callPackage ./custom {};
          lib = lib; };
        importList = [ ./misc.nix ./shell.nix ./dev ./media.nix ./local ];
    in builtins.foldl' (x: y: x ++ import y args) [] importList;
}
