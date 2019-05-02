{ pkgs, ... }:

with pkgs; [
  glibcInfo

  haskellPackages.dhall
  haskellPackages.hoogle
  cabal2nix

  doxygen

  texlive.combined.scheme-basic
  poppler
  pandoc

  solargraph

  httpstat
  mycli
  pgcli
  asciinema
]
