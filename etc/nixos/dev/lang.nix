{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # c family
    gcc gdb llvmPackages.clang-unwrapped llvm lldb
    binutils ninja cmake gnumake

    # haskell
    ghc
    cabal-install
    stack

    ruby bundler bundix ## rbenv; not! use nix instead.
    
    python3Full

    nodejs
  ];
}
