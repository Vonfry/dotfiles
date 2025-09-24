{ config, lib, ... }:

# We put all configs here instead of seperate files to keep other files
# unrelated to preservation.

with lib;
let
  cfg' = config.home-manager.users.vonfry;
  cfg = cfg'.vonfry;

  username = config.users.users.vonfry.name;
  usergroup = config.users.users.vonfry.group;
  homeDir = cfg'.home.homeDirectory;
  inherit (cfg'.xdg)
    cacheHome
    configHome
    dataHome
    stateHome
    ;

  mkHomeRelpath = path: removePrefix "${homeDir}/" path;

  mkCacheRelpath = path: mkHomeRelpath "${cacheHome}/${path}";
  mkDataRelpath = path: mkHomeRelpath "${dataHome}/${path}";
  mkConfigRelpath = path: mkHomeRelpath "${configHome}/${path}";

  envcfg = cfg.environment;
  mkEnvdir =
    name:
    optional (envcfg.${name}.enable && !envcfg.${name}.manual) (
      mkHomeRelpath envcfg.${name}.absolute_path
    );
  envdir = {
    directories = mkMerge (
      map mkEnvdir [
        "dotfiles"
        "repos"
        "orgmode"
        "financial"
      ]
    );
  };

  xdg = mkIf cfg'.xdg.enable {
    directories = mkMerge [
      (mkIf cfg'.xdg.userDirs.enable (
        map mkHomeRelpath [
          # user dirs
          # download and desktop aren't here. Let us clean it everytime!
          cfg'.xdg.userDirs.documents
          cfg'.xdg.userDirs.music
          cfg'.xdg.userDirs.pictures
          cfg'.xdg.userDirs.publicShare
          cfg'.xdg.userDirs.templates
          cfg'.xdg.userDirs.videos
        ]
      ))
      [
        (mkHomeRelpath stateHome)
        (mkDataRelpath "Trash")
      ]
    ];
  };

  emacs = {
    files = [
      {
        file = (mkHomeRelpath "${configHome}/emacs/local/custom.el");
        how = "symlink";
      }
    ];
    directories = [
      (mkCacheRelpath "emacs")
      (mkDataRelpath "emacs")
    ];
  };

  useronlydir = {
    user = username;
    group = usergroup;
    mode = "0700";
  };

  shell = {
    files = [
      {
        file = ".ssh/known_hosts";
        mode = "0600";
        parent = useronlydir;
        # configureParent = true;
      }
    ]
    ++ map mkDataRelpath [
    ]
    ++ map mkConfigRelpath [
    ];
    directories =
      map mkCacheRelpath [
        "fsh"
      ]
      ++ map mkConfigRelpath [
      ]
      ++ map mkDataRelpath [
      ];
  };

  application = {
    files = map mkDataRelpath [
      "ytdl-netrc.gpg"
    ];
    directories = [
      ".mozilla"
    ]
    ++ [
      {
        directory = mkHomeRelpath cfg'.programs.password-store.settings.PASSWORD_STORE_DIR;
        mode = "0700";
      }
    ]
    ++ map mkCacheRelpath [
      "fontconfig"
      "mozilla"
      "mpv"
      "mu"

      "nix"
      "nixpkgs-review"

      "yt-dlp"
    ]
    ++ map mkConfigRelpath [
      "easyeffects"
      "fcitx5"
      "ibus"
    ]
    ++ map mkDataRelpath [
      "fcitx5/rime/build"
      "fcitx5/rime/hangyl.userdb"
      "fcitx5/rime/hannomPS.userdb"
      "fcitx5/rime/japanese.userdb"
      "fonts"
      "mpd"
      "pipewire"
    ];
  };

  gpgbase = mkHomeRelpath cfg'.programs.gpg.homedir;

  development = {
    files = [
      ".cargo/.crates2.json"
      ".cargo/.crates2.toml"
      ".cargo/.global-cache"
      ".cargo/.package-cache"
      ".cargo/.package-cache-mutate"

      ".ghc/ghci_history"

      ".sly-mrepl-history"

      {
        file = "${gpgbase}/trustdb.gpg";
        mode = "0600";
        parent = useronlydir;
        # configureParent = true;
      }
      {
        file = "${gpgbase}/random_seed";
        mode = "0600";
        parent = useronlydir;
        # configureParent = true;
      }
      {
        file = "${gpgbase}/pubring.kbx";
        parent = useronlydir;
        # configureParent = true;
        mode = "0600";
      }
    ];
    directories = [
      ".android"

      ".cargo/git"
      ".cargo/registry"

      {
        directory = "${gpgbase}/crls.d";
        mode = "0700";
        parent = useronlydir;
        # configureParent = true;
      }
      {
        directory = "${gpgbase}/openpgp-revocs.d";
        parent = useronlydir;
        # configureParent = true;
        mode = "0700";
      }
      {
        directory = "${gpgbase}/private-keys-v1.d";
        parent = useronlydir;
        # configureParent = true;
        mode = "0700";
      }

      ".texlive2023"
      ".texlive2024"
      ".texlive2025"
    ]
    ++ map mkCacheRelpath [
      "cabal"
      "common-lisp"
      "containers"
      "direnv"
      "ghcide"
      "hie-bios"
      "mesa_shader_cache"
      "mesa_shader_cache_db"
    ]
    ++ map mkConfigRelpath [
      "cabal"
    ]
    ++ map mkDataRelpath [
      "containers"
      "direnv"
      "nix"
      "nvfetcher"
    ];
  };

  x = {
    files = [
      ".xmonad/prompt-history"
    ]
    ++ map mkConfigRelpath [
      "QtProject.conf"
    ]
    ++ map mkDataRelpath [
    ];
    directories = [
      ".vnc"
    ]
    ++ map mkCacheRelpath [
      "gstreamer-1.0"
    ]
    ++ map mkConfigRelpath [
      "dconf"
      "qt5ct"
      "qt6ct"
      "weylus"
    ]
    ++ map mkDataRelpath [
      "xorg"
    ];
  };

  game = mkIf cfg.game.enable {
    directories = map mkDataRelpath [
      "osu"
    ];
  };
in
{
  config = mkIf cfg.enable {
    vonfry.preservation.home = mkMerge [
      envdir
      xdg
      emacs
      shell
      development
      x
      application
      game
    ];
    # Create some directories with custom permissions.
    #
    # There is an issue on parents with conflictions caused by #16.
    # FIXME Before it is fixed, we override it manually.
    systemd.tmpfiles.settings.preservation = {
      "${homeDir}/${gpgbase}".d = mkForce useronlydir;
      "${homeDir}/.ssh".d = mkForce useronlydir;
    };
  };
}
