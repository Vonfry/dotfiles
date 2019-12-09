{ pkgs, ... }:

with pkgs; [
  handbrake
  graphviz
  gnuplot
  chromium
  feh
  libsForQt5.vlc
  inkscape
  gimp
  qbittorrent
  mupdf
  unstable.tor-browser-bundle-bin
]
