{ config, pkgs, ... }:

let lib = import (dirOf <nixos-config> + /libs); in
{
  imports = lib.matchFiles ./. "default\\.local\\.nix" [];
  users.users.vonfry.packages = with import (dirOf <nixos-config> + /libs);
    let args = { pkgs = pkgs; customDir = ./custom; };
        importList = [ ./misc.nix ./shell.nix ./dev ./media.nix ];
    in builtins.foldl' (x: y: x ++ import y args) [] importList;
}
