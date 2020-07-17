{ pkgs, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ];
    shell = pkgs.zsh;
  };

  home-manager.users.vonfry = import ./home.nix;
}
