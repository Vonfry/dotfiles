{ pkgs, ... }:

with pkgs; [
  mu isync
  rclone
  clash
  firefox
  chromium
  qbittorrent
  jekyll
]
