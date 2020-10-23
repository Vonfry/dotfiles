{ lib, ... }:

with lib;
{
  options.vonfry = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = ''
        Whether to configure system with Vonfry configuration.
      '';
    };
  };

  imports = [
    ./base.nix
    ./development.nix
    ./network.nix
    ./shell.nix
    ./x.nix
    ./misc.nix
  ];
}
