{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloc
  ];

  imports = [
    ./lang.nix
    ./vm.nix
    ./misc.nix
  ];
}
