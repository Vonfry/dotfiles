{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
    pythonPkgs = customPkgs.python;
in
with pkgs; [
  zeal

  glibcInfo
  clang-tools

  ghc
  cabal-install
  haskellPackages.dhall
  haskellPackages.hoogle
  haskellPackages.stylish-haskell
  cabal2nix
  hie

  rustup
  carnix

  pythonPkgs

  ruby bundix ## rbenv; not! use nix instead.
  rubyPkgs

  doxygen

  coq

  nodejs

  texlive.combined.scheme-full
  poppler
  pandoc

  solargraph
  ctags
]
