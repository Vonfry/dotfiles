{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ dunst ];
  services.xserver.displayManager.setupCommands = ''
    dunst &
  '';
}
