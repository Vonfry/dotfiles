{ lib, pkgs, ... }:

with pkgs; [
  gnuplot
] ++ lib.optionals stdenv.isLinux [
  nomachine-client
  feh
  libsForQt5.vlc
  inkscape
  gimp
  unstable.tor-browser-bundle-bin
  zerotierone
  handbrake # numactl works on linux # wait for pr https://github.com/NixOS/nixpkgs/pull/89674
  zathura
]
