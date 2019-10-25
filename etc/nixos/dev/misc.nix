{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    patchelf
  ];
}
