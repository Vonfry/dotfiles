{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    silver-searcher
    gawk
    cloc
  ];

  imports = [ 
    ./lang.nix
    ./db.nix
    ./misc.nix
  ];
}
