{ config, lib, ... }:

# We put all configs here instead of seperate files to keep other files
# unrelated to preservation.

with lib;
let
  cfg' = config.home-manager.users.vonfry;
  cfg = cfg'.vonfry;

  homeDir = cfg'.home.homeDirectory;
  inherit (cfg'.xdg) cacheHome configHome dataHome stateHome;

  username = config.users.users.vonfry.name;
  usergroup = config.users.users.vonfry.group;

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

  shell = {
    files = [
      {
        file = ".ssh/id_ed25519";
        mode = "0600";
      }
      {
        file = ".ssh/id_ed25519.pub";
        mode = "0600";
      }
      {
        file = ".ssh/rsa";
        mode = "0600";
      }
      {
        file = ".ssh/rsa.pub";
        mode = "0600";
      }
      {
        file = ".ssh/known_hosts";
        mode = "0600";
      }
    ] ++ map mkDataRelpath [
    ] ++ map mkConfigRelpath [
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
    ] ++ [
      {
        directory = mkHomeRelpath
          cfg'.programs.password-store.settings.PASSWORD_STORE_DIR;
        mode = "0700";
      }
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
        mode = "0600";
      }
      {
        file = "${gpgbase}/trustdb.gpg";
        mode = "0600";
      }
      {
        file = "${gpgbase}/random_seed";
        mode = "0600";
      }
      {
        file = "${gpgbase}/pubring.kbx";
	configureParent = false;
	how = "symlink";
        mode = "0600";
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
    # This is manily for hm service to make links and normal program usage.
    systemd.tmpfiles.settings.preservation = {
      "${homeDir}/${gpgbase}".d = { user = username; group = usergroup; mode = "0700"; };
      "${homeDir}/.ssh".d = { user = username; group = usergroup; mode = "0700"; };
      "${homeDir}/.xmonad".d = { user = username; group = usergroup; mode = "0755"; };
      ${cacheHome}.d = { user = username; group = usergroup; mode = "0755"; };
      ${configHome}.d = { user = username; group = usergroup; mode = "0755"; };
      "${configHome}/fish".d = { user = username; group = usergroup; mode = "0755"; };
      "${configHome}/emacs".d = { user = username; group = usergroup; mode = "0755"; };
      "${configHome}/emacs/local".d = { user = username; group = usergroup; mode = "0755"; };
      "${homeDir}/.local".d = { user = username; group = usergroup; mode = "0755"; };
      ${dataHome}.d = { user = username; group = usergroup; mode = "0755"; };
      "${dataHome}/nyxt".d = { user = username; group = usergroup; mode = "0755"; };
      "${dataHome}/fcitx5".d = { user = username; group = usergroup; mode = "0755"; };
      "${dataHome}/fcitx5/rime".d = { user = username; group = usergroup; mode = "0755"; };
      "${dataHome}/icons".d = { user = username; group = usergroup; mode = "0755"; };
      "${homeDir}/.cargo".d = { user = username; group = usergroup; mode = "0755"; };
      "${homeDir}/.ghc".d = { user = username; group = usergroup; mode = "0755"; };
    };
  };
}
