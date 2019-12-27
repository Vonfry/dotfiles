{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ dunst libnotify ];
}
