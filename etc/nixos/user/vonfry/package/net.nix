{ pkgs, lib, ... }:

with pkgs; [
  nmap
  mu
  # isync
  jekyll
] ++ lib.optionals (!stdenv.isDarwin) [
  wireshark
  # firefox
  chromium

  vnstat
  iftop
  clash
  qbittorrent
  rclone
]
