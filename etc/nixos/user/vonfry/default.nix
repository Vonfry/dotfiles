args@{ config, pkgs, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" "vboxusers" ];
    shell = pkgs.zsh;
  };
  imports = [ ./local ];
  home-manager.users.vonfry = import ./home.nix args;
}
