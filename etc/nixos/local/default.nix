{ config, pkgs, ... }:

let 
  thisDir = builtins.readDir ./.;
  isLocalNixFile = (name: name != "default.nix" && builtins.match ".*\\.nix" name != null);
  fileNames = builtins.filter isLocalNixFile (builtins.attrNames thisDir);
  files = builtins.map (n: ./. + ("/" + n)) fileNames;
in
{
  imports = files;
}
