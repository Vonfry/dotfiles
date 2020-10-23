{ lib, ... }:

with lib;
{
  options.vonfry = {
    enable = mkEnableOption "Vonfry configuration";
    publicPC = mkEnableOption "private pc";
  };

  imports = [
    ./base.nix
    ./development.nix
    ./network.nix
    ./shell.nix
    ./x.nix
    ./misc.nix
  ];
}
