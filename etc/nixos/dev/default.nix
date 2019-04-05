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
    ./misc.nix
  ];
}
