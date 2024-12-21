{ config, lib, ... }:

# In this module, some useful environments (includes dir, its environment
# variables, and etc ) is are defined.

with lib;
let
  cfg' = config.vonfry;
  cfg = config.vonfry.environment;

  mkEnvDir = name: {
    enable = mkEnableOption "vonfry's basic dir for ${name}";
    manual = mkEnableOption "Whether this dir is manual configured. If enabled, all modules operation on this dir is emitted, such as presist.";
    absolute_path = mkOption {
      default = "${config.home.homeDirectory}/${name}";
      description = "The absolute path for this dir. It must be in `home.homeDirectory`. Otherwise, some undefined behaviour may be take.";
      type = types.str;
    };
    home_path = mkOption {
      default = removePrefix "${config.home.homeDirectory}/" cfg.${name}.absolute_path;
      description = "The path related to home.";
      readOnly = true;
      type = types.str;
    };
    sessionVariable = mkOption {
      default = "${toUpper name}_DIR";
      description = "The variable name for this dir.";
      type = types.str;
    };
  };

  mkSessionVariable =
    name:
    optionalAttrs cfg.${name}.enable {
      ${cfg.${name}.sessionVariable} = cfg.${name}.absolute_path;
    };
in
{
  options.vonfry.environment = {
    dotfiles = mkEnvDir "dotfiles";
    repos = mkEnvDir "repos";
    orgmode = mkEnvDir "orgmode";
    financial = mkEnvDir "financial";
  };
  config = mkMerge [
    {
      vonfry.environment = {
        dotfiles.enable = mkDefault cfg'.enable;
        repos.enable = mkDefault cfg'.enable;
        orgmode.enable = mkDefault cfg'.enable;
        financial.enable = mkDefault cfg'.enable;

        financial.absolute_path = mkDefault "${config.xdg.dataHome}/financial";
        orgmode.absolute_path = mkDefault "${config.xdg.dataHome}/orgmode";
      };
    }
    (mkIf cfg'.enable {
      home.sessionVariables = mkMerge (
        map mkSessionVariable [
          "dotfiles"
          "repos"
          "orgmode"
          "financial"
        ]
      );
    })
  ];
}
