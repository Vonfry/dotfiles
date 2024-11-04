{ config, lib, ... }:

with lib;
{
  options.vonfry = {
    enable = mkEnableOption "Vonfry configuration";
    workspace = {
      server = mkEnableOption "Server mode with some options disabled.";
      home = mkEnableOption "Home mode with some options disabled.";
    };
  };

  config = {
    vonfry.workspace.home = mkDefault (!config.vonfry.workspace.server);
  };
}
