{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sqlite
    mysql
    postgresql
    redis
  ];
}
