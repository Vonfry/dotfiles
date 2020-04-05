{ pkgs, ... }:

with pkgs; [
  mu isync
  rclone
  vdirsyncerStable khard khal
  clash
  firefox
  chromium
  qbittorrent
]
