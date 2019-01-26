{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zlib
    libffi
    libxml2
    dbus
  ];
}
