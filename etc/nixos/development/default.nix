{ config, pkgs, ... }:

{
  imports = [
    ./lang.nix
    ./vm.nix
  ];
}
