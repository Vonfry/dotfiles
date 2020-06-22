{ pkgs, lib, ... }:

with pkgs; [
  nmap
  vnstat
  iftop

  mu isync
  rclone
  clash
  qbittorrent
  jekyll
] ++ lib.optional (!stdenv.isDarwin) [
  wireshark
  firefox
  chromium
]
