{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # c family
    llvmPackages.clang llvm lldb
    ninja cmake gnumake

    # haskell
    ghc
    cabal-install

    ruby bundler bundix ## rbenv; not! use nix instead.

    python3Full

    nodejs
  ];
}
