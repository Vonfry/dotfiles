{ config, lib, pkgs, ... }:

{
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

    starship.enable = true;

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
          rev = "aed8c0ed0adc5a4b8858656cdc1028300a52c104";
          sha256 = "14lg3k6nxm66pg0c5j71wp8b4n18qnnr5lkc0szdw9vn3drrcfnm";
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
        name = "you-should-use";
        src = fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.7.3";
          sha256 = "1dz48rd66priqhxx7byndqhbmlwxi1nfw8ik25k0z5k7k754brgy";
        };
      }];
      history = {
        extended = true;
        save = 100000;
        size = 100000;
        path = "${config.xdg.configHome}/zsh/zsh_history";
      };
      envExtra= ''
        PATH=~/.local/bin:$PATH
      '';
      initExtra = with lib; with builtins; ''
        setopt nomatch
        setopt extendedglob
        setopt rm_star_silent
        setopt clobber

        eval "$(jump shell)"
      '' + concatStringsSep "\n"
        (map (f: readFile (./files/zsh/rc.d + ("/" + f)))
          (attrNames
            (filterAttrs (n: v: v == "regular"
                            && (hasSuffix ".sh" n || hasSuffix ".zsh" n))
              (readDir ./files/zsh/rc.d))));
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
            fortune -s ${config.home.sessionVariables.CLONE_LIB}/fortunes/data all
            print
          fi

        } >&2
      '';
      shellAliases = {
        lla = "ls -lAh";
        ecd = "emacs --daemon";
        ecq = "emacsclient -q -t -e \"(kill-emacs)\"";
        ecc = "emacsclient -n -c";
        ect = "emacsclient -t";

        opF = "op-format";
        opgi = "op get item";
        opf = "op-fuzzy-search-from-json";
        opr = "op-refresh-my";
        op-init = "op signin my.1password.com";
      };
    };

    htop = {
      enable = true;
      treeView = true;
      meters = {
        left = [
           { kind = "AllCPUs"; mode = 2; }
           { kind = "Memory" ; mode = 2; }
           { kind = "Swap"   ; mode = 2; }
        ];
        right = [
          { kind = "Clock"   ; mode = 2; }
          { kind = "Battery" ; mode = 2; }
          "Blank"
          { kind = "Tasks"   ; mode = 2; }
          { kind = "Uptime"  ; mode = 2; }
          "LoadAverage"
        ];
      };
    };
  };

  home = {
    file = {
      "${config.programs.zsh.dotDir}/.zpreztorc".source = ./files/zsh/zpreztorc;
      ".local/bin/op-fuzzy-search-from-json" = {
        source = ./files/bin/op-fuzzy-search-from-json;
        executable = true;
      };
    };

    activation.shellActivation =
      let
        inherit (config.home.sessionVariables) DOTFILES_DIR ORG_DIR PASSWD_DIR
          CLOUD_DIR CLONE_LIB;
      in lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p ${config.xdg.cacheHome} ~/.local
        if [ -z "${DOTFILES_DIR}"  ]; then
          $DRY_RUN_CMD echo "file is copied, please edit it(${toString ./local/session.nix}). Then prepare for cloud files. "
          exit -1
        fi
        ! [ -h ${ORG_DIR} ] && $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${CLOUD_DIR}/dotfiles/orgmode ${ORG_DIR}
        $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${CLOUD_DIR}/dotfiles/config/emacs.d/local/* ${toString config.xdg.configHome}/emacs.d/local
        $DRY_RUN_CMD mkdir -p ${CLONE_LIB} ${PASSWD_DIR}
        if ! [ -f ${PASSWD_DIR}/authinfo.gpg ]; then
          $DRY_RUN_CMD echo "please create authinfo.gpg file under ${PASSWD_DIR}"
          $DRY_RUN_CMD read
        fi
        ! [ -f ${toString config.xdg.configHome}/bg.png ] && $DRY_RUN_CMD curl $VERBOSE_ARG https://wiki.haskell.org/wikistatic/haskellwiki_logo.png -o ${toString config.xdg.configHome}/bg.png
        if ! [ -d ${CLONE_LIB}/fortunes ]; then
          $DRY_RUN_CMD git clone https://github.com/ruanyf/fortunes.git ${CLONE_LIB}/fortunes
          $DRY_RUN_CMD strfile ${CLONE_LIB}/fortunes/data/fortunes
          $DRY_RUN_CMD strfile ${CLONE_LIB}/fortunes/data/chinese
          $DRY_RUN_CMD strfile ${CLONE_LIB}/fortunes/data/tang300
          $DRY_RUN_CMD strfile ${CLONE_LIB}/fortunes/data/song100
          $DRY_RUN_CMD strfile ${CLONE_LIB}/fortunes/data/diet
        fi
        if ! [ -f ~/.face.icon ]; then
          $DRY_RUN_CMD curl $VERBOSE_ARG https://vonfry.name/static/images/default/logo.png -o ~/.face.icon
          setfacl -m u:sddm:x ~/
          setfacl -m u:sddm:r ~/.face.icon
        fi
      '';

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "qutebrowser";
    };

    packages = with pkgs; [
      wget curl
      git git-lfs
      zsh gnupg
      file
      fzf jump
      colordiff
      tmux
      w3m
      patch
      zip unzip
      ripgrep
      fd
      exa
      bat

      gitAndTools.gitflow tig gitAndTools.git-extras
      zsh fzf
      direnv
      thefuck
      lorri
      ranger
      parallel
      lolcat
      fortune cmatrix figlet
      asciinema
      neofetch

      flameshot
      atop htop
      alacritty
      lm_sensors lsof
      sshfs
    ];
  };
}
