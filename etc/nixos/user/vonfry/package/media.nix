{ lib, pkgs, ... }:

with pkgs;
[ handbrake
  graphviz
  gnuplot
] ++ lib.optional (!stdenv.isDarwin)
[ nomachine-client
  feh
  libsForQt5.vlc
  inkscape
  gimp
  unstable.tor-browser-bundle-bin
  zerotierone
  zathura
]

