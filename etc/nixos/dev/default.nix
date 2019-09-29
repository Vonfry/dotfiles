{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    gawk
    cloc
  ];

  imports = [
    ./lang.nix
    ./vm.nix
    ./misc.nix
  ];
}
