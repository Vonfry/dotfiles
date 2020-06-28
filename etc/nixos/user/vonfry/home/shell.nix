{ lib, config, pkgs, ... }:

let
  defvarFile = builtins.concatStringsSep "/" [ "$HOME"
                                               config.programs.zsh.dotDir
                                               "defvar.sh"
                                             ];
  localvarFile = builtins.concatStringsSep "/" [ "$HOME"
                                                 config.programs.zsh.dotDir
                                                 "localvar.sh"
                                               ];
  isDarwin = pkgs.stdenv.isDarwin;
  zshrcDir = ./files/zsh/rc.d;
in {
  programs = {
    man.enable = true;
    bat.enable = true;
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      shortcut = "\\";
      extraConfig = ''
        set -g update-environment -r
        set -g status-right "#{tmux_mode_indicator}"
        unbind C-b
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d";
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
    };
    ssh = {
      enable = true;
      compression = true;
      forwardAgent = true;
      serverAliveInterval = 60;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      plugins = with pkgs; [{
        name = "prezto";
        file = "init.zsh";
        src = fetchFromGitHub {
          owner = "Vonfry";
          repo = "prezto";
          rev = "6c5dd207bbda0f264f0136a31af36636b508f242";
          sha256 = "0adwv9qq3pq7wkwincqd2j38w4jqa3z01h8yqgq518hb30iaq6yj";
          fetchSubmodules = true;
        };
      } {
        name = "git-open";
        src = fetchFromGitHub {
          owner = "paulirish";
          repo = "git-open";
          rev = "d9a0d19ce291ab09d182e389edaa278bb2febb11";
          sha256 = "1a1w8jya851mq692dahdhy9kgkn0z1801cfzdcw6ra78pily22i6";
        };
      } {
        name = "zsh-async";
        src = fetchFromGitHub {
          owner = "mafredri";
          repo = "zsh-async";
          rev = "v1.8.3";
          sha256 = "1vlr8fkk3k4cz3sxz3qmlkfsqxw251igbn9raz3lga4p213m98jb";
        };
        file = "async.zsh";
      } {
        name = "enhancd";
        src = fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.4";
          sha256 = "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
        };
        file = "init.sh";
      } {
        name = "you-should-use";
        src = fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.7.3";
          sha256 = "1dz48rd66priqhxx7byndqhbmlwxi1nfw8ik25k0z5k7k754brgy";
        };
      } {
        name = "geometry";
        file = "geometry.zsh";
        src = fetchFromGitHub {
          owner = "geometry-zsh";
          repo = "geometry";
          rev = "v2.2.0";
          sha256 = "0sy5v3id31k4njr5pamh4hx238x0pcpgi0yh90jpbci690i8vdab";
        };
      }];
      envExtra = ''
        if [ -f ${defvarFile} ]; then
          . ${defvarFile}
        fi
        export PATH=${toString ./files/bin}:~/.local/bin:$PATH
      '';
      initExtra = ''
        setopt nomatch
        setopt extendedglob
        setopt rm_star_silent
        setopt clobber

        [ -f ${localvarFile} ] && . ${localvarFile}
      '' + builtins.concatStringsSep "\n"
        (map (f: lib.optionalString (builtins.isList (builtins.match "^.*\\.z?sh$" f))
                                    "source ${toString zshrcDir}/${f}")
          (builtins.attrNames
            (lib.filterAttrs (n: v: v == "regular")
              (builtins.readDir zshrcDir))));
      initExtraBeforeCompInit  = ''
      '';
      localVariables = {
        GEOMETRY_PROMPT_PLUGINS = [ "exec_time" "jobs" "git" "hg" "kube"];
        ENHANCD_DIR = "$HOME/.cache/enchancd";
        ENHANCD_FILTER = "fzf";
        ENHANCD_USE_FUZZY_MATCH = 0;
        ENHANCD_COMPLETION_BEHAVIOR = "list";
      };
      loginExtra = ''
        # Execute code that does not affect the current session in the background.
        {
          # Compile the completion dump to increase startup speed.
          zcompdump="''${ZDOTDIR:-$HOME}/.zcompdump"
          if [[ -s "$zcompdump" && (! -s "''${zcompdump}.zwc" || "$zcompdump" -nt "''${zcompdump}.zwc") ]]; then
            zcompile "$zcompdump"
          fi
        } &!

        # Execute code only if STDERR is bound to a TTY.
        [[ -o INTERACTIVE && -t 2 ]] && {

          # Print a random, hopefully interesting, adage.
          if (( $+commands[fortune] )); then
            fortune -s ~/.local/src/fortunes/data all
            print
          fi

        } >&2
      '';
      logoutExtra = ''
      '';
      profileExtra = lib.optionalString isDarwin ''
        . ~/.nix-profile/etc/profile.d/nix.sh
      '';
      sessionVariables = {
      };
      shellAliases = {
        lla = "ls -lAh";
        ecd = "emacs --daemon";
        ecq = "emacsclient -q -t -e \"(kill-emacs)\"";
        ecc = "emacsclient -n -c";
        ect = "emacsclient -t";

        opF = "op-format";
        opgi = "op get item";
        opp = "op-get-password-from-json";
        opf = "op-fuzzy-search-from-json";
        opr = "op-refresh-sign";
        op-init = "op-sign-my";
      };
    };
    htop = {
      enable = !isDarwin;
      treeView = true;
    };
  };
  home = {
    file = {
      "${config.programs.zsh.dotDir}/.zpreztorc".source = ./files/zsh/zpreztorc;
    };
    activation.shellActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ~/.cache ~/.local
      if ! [ -f ${defvarFile} ]; then
        $DRY_RUN_CMD cp $VERBOSE_ARG ${toString ./files/zsh/defvar.sh.example} ${defvarFile}
        $DRY_RUN_CMD echo "defvar file is copied, please edit it(${defvarFile}). Then prepare for cloud files"
        $DRY_RUN_CMD read
      fi
      $DRY_RUN_CMD . ${defvarFile}
      ! [ -h $ORG_DIR ] && $DRY_RUN_CMD ln $VERBOSE_ARG -sf $CLOUD_DIR/dotfiles/org $ORG_DIR
      $DRY_RUN_CMD ln $VERBOSE_ARG -sf $CLOUD_DIR/dotfiles/config/emacs.d/local/* ~/.config/emacs.d/local
      $DRY_RUN_CMD mkdir -p $CLONE_LIB $PASSWD_DIR
      if ! [ -f $PASSWD_DIR/authinfo.gpg ]; then
        $DRY_RUN_CMD echo "please create authinfo.gpg file under $PASSWD_DIR"
        $DRY_RUN_CMD read
      fi
      ! [ -f ~/.config/bg.png ] && $DRY_RUN_CMD curl $VERBOSE_ARG https://wiki.haskell.org/wikistatic/haskellwiki_logo.png -o ~/.config/bg.png
      if ! [ -d $CLONE_LIB/fortunes ]; then
        $DRY_RUN_CMD git clone https://github.com/ruanyf/fortunes.git $CLONE_LIB/fortunes
        $DRY_RUN_CMD strfile $CLONE_LIB/fortunes/data/fortunes
        $DRY_RUN_CMD strfile $CLONE_LIB/fortunes/data/chinese
        $DRY_RUN_CMD strfile $CLONE_LIB/fortunes/data/tang300
        $DRY_RUN_CMD strfile $CLONE_LIB/fortunes/data/song100
        $DRY_RUN_CMD strfile $CLONE_LIB/fortunes/data/diet
      fi
    '';
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = if isDarwin then "open" else "firefox";
    };
  };
}
