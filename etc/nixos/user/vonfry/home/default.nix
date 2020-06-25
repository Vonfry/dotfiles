{ lib, ... }:

let
  localFiles = with builtins; with lib;
    map (n: ./local + "/${n}")
        (attrNames (filterAttrs
                   (n: v: v != "directory" && isList (match "^.*\\.nix$" n))
                   (readDir ./local)));
in {
  imports = [ ./base.nix
              ./development.nix
              ./net.nix
              ./shell.nix
              ./x.nix
              ./misc.nix
            ] ++ localFiles;
}
