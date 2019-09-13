{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
in
with pkgs; [
  glibcInfo
  clang-tools

  haskellPackages.dhall
  haskellPackages.hoogle
  cabal2nix
  hie

  rustc
  cargo
  rustup

  rubyPkgs

  doxygen

  coq

  texlive.combined.scheme-basic
  poppler
  pandoc

  solargraph

  httpstat
  mycli
  pgcli
  asciinema
]
