{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ exfat ];
  services.davfs2.enable = true;
}
