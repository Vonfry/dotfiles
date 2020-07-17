{ config, pkgs, lib, ... }:

let
  localFiles = with builtins; with lib;
    map (n: ./local + "/${n}")
        (attrNames (filterAttrs
                   (n: v: v != "directory" && isList (match "^.*\\.nix$" n))
                   (readDir ./local)));
in {
  users.motd = builtins.readFile ./motd;

  home-manager.useUserPackages = true;

  imports = [
    ./vonfry
    <home-manager/nixos>
  ] ++ localFiles;
}
