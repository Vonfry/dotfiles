{ pkgs, config, ... }:

let
  defvarFile = toString (config.programs.zsh.dotDir + /defvar.sh);
  localvarFile = toString (config.programs.zsh.dotDir + /localvar.sh);
  conf = {
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
        dotDir = ".config/shell";
        zplug = {
          enable = true;
          plugins = [{
            name = "Vonfry/prezto";
            tags = [ "at:revision/vonfry" ];
          } {
            name = "paulirish/git-open";
          } {
            name = "mafredri/zsh-async";
            tags = [ "use:async.zsh" ];
          } {
            name = "b4b4r07/enhancd";
            tags = [ "use:init.sh" "defer:1" ];
          } {
            name = "MichaelAquilina/zsh-you-should-use";
          } {
            name = "geometry-zsh/geometry";
          }];
        };
        envExtra = ''
          if [ -f ${defvarFile} ]; then
            . ${defvarFile}
          fi
          export PATH=${toString ./files/bin}:~/.local/bin:$PATH
        '';
        initExtra = ''
          setopt nonmatch
          setopt extendedglob
          setopt rm_star_silent
          setopt clobber
        '' + builtins.concatStringsSep "\n"
          (map (f: if builtins.match "^.*\\.z?sh$" f
             then "source ${toString ./.}/${f}"
             else "" )
            (builtins.attrNames
              (lib.filterAttrs (n: v: v == "regular")
                (builtins.readDir ./files/zsh/rc.d))));
        initExtraBeforeCompInit  = ''
        '';
        localVariables = ''
          export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs git hg kube)
          export ENHANCD_DIR=~/.cache/enchancd
          export ENHANCD_FILTER=fzf
          export ENHANCD_USE_FUZZY_MATCH=0
          [ -f ${localvarFile} ] && . ${localvarFile}
        '';
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
        profileExtra = ''
        '';
        sessionVariables = ''
        '';
        shellAliases = {
          ps = "procs";
          lla = "ls -lAh";
          ecd = "emacs --daemon";
          ecq = "emacsclient -q -t -e \"(kill-emacs)\"";
          ecc = "emacsclient -n -c";
          ect = "emacsclient -t";

          opF = op-format;
          opgi = "op get item";
          opp = "op-get-password-from-json";
          opf = "op-fuzzy-search-from-json";
          opr = "op-refresh-sign";
          op-init = "op-sign-my";
        };
      };
    };
    home = {
      file = {
        ".zpreztorc".source = ./files/zsh/zpreztorc;
      };
      activation.shellActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p ~/.cache ~/.local
        if ! [ -f ${defvarFile} ]; then
          $DRY_RUN_CMD cp $VERBOSE_ARG ${toString ./files/zsh/defvar.sh.example} ${defvarFile}
          $DRY_RUN_CMD echo "defvar file is copied, please edit it."
          $DRY_RUN_CMD read
        fi
        $DRY_RUN_CMD . ${defvarFile}
        $DRY_RUN_CMD ln $VERBOSE_ARG -sf $CLOUD_DIR/dotfiles/org $ORG_DIR
        $DRY_RUN_CMD ln $VERBOSE_ARG -sf $CLOUD_DIR/dotfiles/emacs.d/local/* ~/.config/emacs.d/local
        $DRY_RUN_CMD mkdir -p $CLONE_LIB $PASSWD_DIR
        if ! [ -f $PASSWD_DIR/authinfo.gpg ]; then
          $DRY_RUN_CMD echo "please create authinfo.gpg file under $PASSWD_DIR"
          $DRY_RUN_CMD read
        fi
        ! [ -f ~/.config/bg.png ] && $DRY_RUN_CMD curl $VERBOSE_ARG https://wiki.haskell.org/wikistatic/haskellwiki_logo.png -O ~/.config/bg.png
        if ! [ -f $CLONE_LIB/fortunes ]; then
          $DRY_RUN_CMD git clone https://github.com/ruanyf/fortunes.git ~/.local/src/fortunes
          $DRY_RUN_CMD strfile ~/.local/src/fortunes/data/fortunes
          $DRY_RUN_CMD strfile ~/.local/src/fortunes/data/chinese
          $DRY_RUN_CMD strfile ~/.local/src/fortunes/data/tang300
          $DRY_RUN_CMD strfile ~/.local/src/fortunes/data/song100
          $DRY_RUN_CMD strfile ~/.local/src/fortunes/data/diet
        fi
      '';
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  confLinux = {
    programs = {
      htop = {
        enable = true;
	      treeview = true;
      };
    };
    home.sessionVariables = {
      BROWSER = "firefox";
    };
  };
  confDarwin = {
    home.sessionVariables = {
      BROWSER = "open";
    };
  };
in conf // (if (!pkgs.stdenv.isDarwin) then confLinux else confDarwin)
