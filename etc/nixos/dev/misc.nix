{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    wireshark-cli
  ];
}
