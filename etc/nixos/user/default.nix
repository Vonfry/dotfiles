{ config, pkgs, lib, ... }:

{
  users.motd = builtins.readFile ./motd;
  imports = [
    ./vonfry
    ./local
  ];
}
