{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloc
    binutils-unwrapped
    # c family
    llvmPackages.clang llvm lldb
    cmake gnumake

    patchelf

    docker
    docker_compose
    patchelf
  ];

  virtualisation = {
    virtualbox.host.enable = true;
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };
}
