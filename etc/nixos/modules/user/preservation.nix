{ config, lib, ... }:

# We put all configs here instead of seperate files to keep other files
# unrelated to impermanence.

with lib;
let
  cfg' = config.home-manager.users.vonfry;
  cfg = cfg'.vonfry;

  homeDir = cfg'.home.homeDirectory;
  inherit (cfg'.xdg) cacheHome configHome dataHome stateHome;

  mkHomeRelpath = path: removePrefix "${homeDir}/" path;

  mkCacheRelpath = path: mkHomeRelpath "${cacheHome}/${path}";
  mkDataRelpath = path: mkHomeRelpath "${dataHome}/${path}";
  mkConfigRelpath = path: mkHomeRelpath "${configHome}/${path}";

  envcfg = cfg.environment;
  mkEnvdir = name:
    optional
      (envcfg.${name}.enable && !envcfg.${name}.manual)
      (mkHomeRelpath envcfg.${name}.absolute_path);
  envdir = {
    directories = mkMerge (map mkEnvdir [
      "dotfiles"
      "repos"
      "orgmode"
      "financial"
    ]);
  };

  xdg = mkIf cfg'.xdg.enable {
    directories = mkMerge [
      (mkIf cfg'.xdg.userDirs.enable (map mkHomeRelpath [
        # user dirs
        # download and desktop aren't here. Let us clean it everytime!
        cfg'.xdg.userDirs.documents
        cfg'.xdg.userDirs.music
        cfg'.xdg.userDirs.pictures
        cfg'.xdg.userDirs.publicShare
        cfg'.xdg.userDirs.templates
        cfg'.xdg.userDirs.videos
      ]))
      [
        (mkHomeRelpath stateHome)
        (mkDataRelpath "Trash")
      ]
    ];
  };

  emacs = {
    files = [
      "${configHome}/emacs/local/custom.el"
    ];
    directories = [
      (mkCacheRelpath "emacs")
      (mkDataRelpath "emacs")
    ];
  };

  shell = {
    files = [
      {
        file = ".ssh/id_ed25519";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = ".ssh/id_ed25519.pub";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = ".ssh/rsa";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = ".ssh/rsa.pub";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = ".ssh/known_hosts";
        configureParent = true;
        parent.mode = "0700";
      }
    ] ++ map mkDataRelpath [
    ] ++ map mkConfigRelpath [
      "fish/fish_variables"
    ];
    directories = map mkCacheRelpath [
      "fsh"
      "starship"
    ] ++ map mkConfigRelpath [
      # TODO try this? "fish"
    ] ++ map mkDataRelpath [
      "fish"
    ];
  };

  application = {
    files = map mkDataRelpath [
      "nyxt/default-cookies"
      "nyxt/nyxt.log"
      "ytdl-netrc.gpg"
    ];
    directories = [
      ".mozilla"
    ] ++ map mkHomeRelpath [
       cfg'.programs.password-store.settings.PASSWORD_STORE_DIR
    ] ++ map mkCacheRelpath [
      "aria2"
      "fontconfig"
      "mozilla"
      "mpv"
      "mu"

      "nix"
      "nixpkgs-review"

      "nyxt"
      "virt-manager"
      "yt-dlp"
    ] ++ map mkConfigRelpath [
      "easyeffects"
      "fcitx5"
      "ibus"
      "libreoffice"
    ] ++ map mkDataRelpath [
      "fcitx5/rime/build"
      "fcitx5/rime/hangyl.userdb"
      "fcitx5/rime/hannomPS.userdb"
      "fcitx5/rime/japanese.userdb"
      "fonts"
      "icons/distrobox"
      "mpd"
      "nyxt/default-web-context"
      "nyxt/history"
      "pipewire"
      "zathura"
      "zoxide"
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
        file = "${gpgbase}/sshcontrol";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = "${gpgbase}/trustdb.gpg";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = "${gpgbase}/random_seed";
        configureParent = true;
        parent.mode = "0700";
      }
      {
        file = "${gpgbase}/pubring.kbx";
        configureParent = true;
        parent.mode = "0700";
      }
    ];
    directories = [
      ".android"

      ".cargo/git"
      ".cargo/registry"

      "${gpgbase}/crls.d"
      "${gpgbase}/openpgp-revocs.d"
      "${gpgbase}/private-keys-v1.d"

      ".texlive2023"
      ".texlive2024"
      ".texlive2025"
    ] ++ map mkCacheRelpath [
      "cabal"
      "common-lisp"
      "containers"
      "direnv"
      "ghcide"
      "hie-bios"
      "libvirt"
      "mesa_shader_cache"
      "mesa_shader_cache_db"
    ] ++ map mkConfigRelpath [
      "cabal"
      "libvirt"
    ] ++ map mkDataRelpath [
      "containers"
      "direnv"
      "nix"
      "nvfetcher"
    ];
  };

  x = {
    files = [
      ".xmonad/prompt-history"
    ] ++ map mkConfigRelpath [
      "QtProject.conf"
    ] ++ map mkDataRelpath [
    ];
    directories = [
      ".vnc"
    ] ++ map mkCacheRelpath [
      "gstreamer-1.0"
    ] ++ map mkConfigRelpath [
      "dconf"
      "qt5ct"
      "qt6ct"
      "weylus"
    ] ++ map mkDataRelpath [
      "Xorg"
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
  };
}
