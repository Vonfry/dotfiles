{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
in
with pkgs; [
  zeal

  glibcInfo
  clang-tools

  haskellPackages.dhall
  haskellPackages.hoogle
  cabal2nix
  hie

  rustup

  rubyPkgs

  doxygen

  coq

  texlive.combined.scheme-basic
  poppler
  pandoc

  solargraph
  ctags

  httpstat
  mycli
  pgcli
  asciinema
]
