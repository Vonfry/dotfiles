{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # c family
    llvmPackages.clang llvm lldb
    ninja cmake gnumake
  ];
}
