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

    ruby ## rbenv; not! use nix instead.
    
    python python3Full python36Packages.pip

    nodejs
  ];
}
