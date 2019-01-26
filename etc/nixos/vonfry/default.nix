{ config, pkgs, ... }:

{
  imports =
    let 
      defaultList =
        [ ./base.local.nix 
          ./base.nix 
          ./network 
          ./shell.nix 
          ./user 
          ./editor.nix 
          ./dev 
          ./misc.nix 
          ./x.nix
        ]; 
    in with import ./libs; mergeList defaultList (matchFiles ./. "[A-z]*\\.local\\.nix" []);
}
