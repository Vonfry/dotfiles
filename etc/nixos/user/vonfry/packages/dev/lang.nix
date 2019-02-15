{ pkgs, ... }:

with pkgs; [
  haskellPackages.brittany
  haskellPackages.dhall
  haskellPackages.hoogle
  cabal2nix

  doxygen
  shfmt
  shellcheck
  yq

  texlive.combined.scheme-basic
  poppler
  pandoc

  solargraph

  httpstat
  mycli
  pgcli
  asciinema
]
