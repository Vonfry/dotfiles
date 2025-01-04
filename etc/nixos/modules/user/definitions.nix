{ config, lib, ... }:

# Because of home-manager's nixos module sets some nixos's config
# and these configs may be used recursively.
# A typical case is that impermanence needs config.fileSystems which needs
# boot.supportedFilesystems that sets users.users, causing that users.users
# cannot be used in impermanence.
#
# To solve this, some home manager's options are redefined here in nixos for
# reading and set them again to make sure equivalent.

with lib;
let
  cfg = config.vonfry;
  hmcfg' = config.home-manager.users.vonfry;
  hmcfg = hmcfg'.vonfry;
in {
  options.vonfry = {
    homeDir = mkOption {
      description = "Map to `home-manager.users.vonfry.home.homeDirectory`";
      type = types.path;
      default = "/home/vonfry";
    };
    cacheHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.cacheHome`.";
      type = types.path;
      default = "${cfg.homeDir}/.cache";
    };
    configHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.configHome`.";
      type = types.path;
      default = "${cfg.homeDir}/.config";
    };
    dataHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.dataHome`.";
      type = types.path;
      default = "${cfg.homeDir}/.local/share";
    };
    stateHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.stateHome`.";
      type = types.path;
      default = "${cfg.homeDir}/.local/state";
    };
    gpgHome = mkOption {
      description = "Map to `home-manager.users.vonfry.programs.gpg.homedir`.";
      type = types.path;
      default = "${cfg.homeDir}/.gnupg";
    };
    documentsHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.documents`.";
      type = types.path;
      default = "${cfg.homeDir}/Documents";
    };
    musicHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.music`.";
      type = types.path;
      default = "${cfg.homeDir}/Music";
    };
    picturesHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.pictures`.";
      type = types.path;
      default = "${cfg.homeDir}/Pictures";
    };
    publicShareHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.publicShare`.";
      type = types.path;
      default = "${cfg.homeDir}/PublicShare";
    };
    templatesHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.templates`.";
      type = types.path;
      default = "${cfg.homeDir}/Templates";
    };
    videosHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.videos`.";
      type = types.path;
      default = "${cfg.homeDir}/Videos";
    };
    downloadHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.download`.";
      type = types.path;
      default = "${cfg.homeDir}/Downloads";
    };
    desktopHome = mkOption {
      description = "Map to `home-manager.users.vonfry.xdg.userDirs.desktop`.";
      type = types.path;
      default = "${cfg.homeDir}/Desktop";
    };
  };

  config = mkIf cfg.enable {
    users.users.vonfry.home = cfg.homeDir;

    home-manager.users.vonfry = {
      vonfry.environment = {
        dotfiles.absolute_path = "${cfg.homeDir}/dotfiles";
        repos.absolute_path = "${cfg.homeDir}/repos";
        orgmode.absolute_path = "${cfg.dataHome}/orgmode";
        financial.absolute_path = "${cfg.dataHome}/financial";
      };

      home.homeDirectory = cfg.homeDir;

      programs.gpg.homedir = cfg.gpgHome;

      xdg = {
        inherit (cfg) cacheHome configHome dataHome stateHome;
        userDirs = {
          documents = cfg.documentsHome;
          music = cfg.musicHome;
          pictures = cfg.picturesHome;
          publicShare = cfg.publicShareHome;
          templates = cfg.templatesHome;
          videos = cfg.videosHome;
        };
      };
    };
  };
}
