{ pkgs, lib, ... }:

with pkgs; [
  nmap
  mu isync
  jekyll
  # qutebrowser
] ++ lib.optionals stdenv.isLinux [
  firefox
  chromium
  wireshark

  vnstat
  iftop
  clash
  qbittorrent
  rclone
]
