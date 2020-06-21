{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [ cloc
      binutils-unwrapped
      # c family
      llvmPackages.clang llvm lldb
      ninja cmake gnumake

      patchelf
    ];
}
