{ config, lib, ... }:

# We put all configs here instead of seperate files to keep other files
# unrelated to impermanence.

with lib;
let
  cfg = config.vonfry;

  mkHomeRelpath = path: removePrefix "${config.home.homeDirectory}/" path;

  inherit (config.xdg) configHome dataHome cacheHome;
  mkCacheRelpath = path: mkHomeRelpath "${cacheHome}/${path}";
  mkDataRelpath = path: mkHomeRelpath "${dataHome}/${path}";
  mkConfigRelpath = path: mkHomeRelpath "${configHome}/${path}";

  base = {
    enable = true;
  };

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

  xdg = mkIf config.xdg.enable {
    directories = mkMerge [
      (mkIf config.xdg.userDirs.enable (map mkHomeRelpath [
        # user dirs
        # download and desktop aren't here. Let us clean it everytime!
        config.xdg.userDirs.documents
        config.xdg.userDirs.music
        config.xdg.userDirs.pictures
        config.xdg.userDirs.publicShare
        config.xdg.userDirs.templates
        config.xdg.userDirs.videos
      ]))
      [
        (mkHomeRelpath config.xdg.stateHome)
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
      ".ssh/id_ed25519"
      ".ssh/id_ed25519.pub"
      ".ssh/rsa"
      ".ssh/rsa.pub"
      ".ssh/known_hosts"
    ] ++ map mkDataRelpath [
      "fish/fish_history"
      "fish/fish_variables"
    ];
    directories = map mkCacheRelpath [
      "fsh"
      "starship"
    ] ++ map mkConfigRelpath [
    ] ++ map mkDataRelpath [
      "fish/generated_completions"
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
       config.programs.password-store.settings.PASSWORD_STORE_DIR
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

  development = {
    files = [
      ".cargo/.crates2.json"
      ".cargo/.crates2.toml"
      ".cargo/.global-cache"
      ".cargo/.package-cache"
      ".cargo/.package-cache-mutate"

      ".ghc/ghci_history"

      ".sly-mrepl-history"
    ];
    directories = [
      ".android"

      ".cargo/git"
      ".cargo/registry"

      (mkHomeRelpath config.programs.gpg.homedir)

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
      "recently-used.xbel"
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
    home.persistence."/persistent${config.home.homeDirectory}" = mkMerge [
      base
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
