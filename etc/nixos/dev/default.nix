{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    gawk
    cloc
  ];

  imports = [
    ./lang.nix
    ./db.nix
    ./vm.nix
    ./misc.nix
  ];
}
