{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    binutils-unwrapped
    # c family
    llvmPackages.clang llvm lldb
    ninja cmake gnumake
  ];
  services.lorri.enable = true;
}
