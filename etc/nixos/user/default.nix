{ config, pkgs, lib, ... }:

{
  users.motd = builtins.readFile ./motd;
  home-manager.useUserPackages = true;
  imports = [
    ./vonfry
    ./local
    <home-manager/nixos>
  ];
}
