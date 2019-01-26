{ config, pkgs, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = 
      let 
        libs = import (<nixos-config> + "/../vonfry/libs");
	vonfryPackages = libs.matchFiles ./. "^[A-z0-9]*\\.pkgs\\.[A-z0-9\\.]*\\.nix$" [];
      in libs.uniqueList (builtins.concatLists (map (path: import path pkgs) vonfryPackages));
  };
}
