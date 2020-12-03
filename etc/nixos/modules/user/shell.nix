{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    programs = {
      tmux = {
        enable = true;
        clock24 = true;
        keyMode = "vi";
        extraConfig = ''
          set -g update-environment -r
          set -g status-right "#{tmux_mode_indicator}"
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

      zsh = {
        enable = true;
        dotDir = ".config/zsh";

        history = {
          extended = true;
          save = 100000;
          size = 100000;
          path = "${config.xdg.configHome}/zsh/zsh_history";
        };

        autocd = true;
        enableCompletion = true;
        defaultKeymap = "emacs";

        localVariables = {
          PATH = "~/.local/bin:$PATH";
          WORDCHARS = "*?_-.[]~&;!#$%^(){}<>";
        };

        initExtra = with pkgs; ''
          setopt nomatch
          setopt extendedglob
          setopt rm_star_silent
          setopt clobber
          setopt combining_chars
          setopt interactive_comments
          setopt rc_quotes
          unsetopt mail_warning
          setopt long_list_jobs
          setopt auto_resume
          setopt notify
          unsetopt bg_nice
          unsetopt hup
          unsetopt check_jobs
          setopt auto_pushd
          setopt pushd_ignore_dups
          setopt pushd_silent
          setopt pushd_to_home
          setopt cdable_vars
          setopt multios
          setopt extended_glob
          unsetopt clobber
          setopt bang_hist

          source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
          source ${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
          source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
          # ${zsh-completions}

          eval "$(jump shell)"
          eval $(thefuck --alias)
          function set_win_title(){
              echo -ne "\033]0; $TERM - $PWD \007"
          }
          precmd_functions+=(set_win_title)

          # Emacs
          bindkey -M emacs "^P" history-substring-search-up
          bindkey -M emacs "^N" history-substring-search-down

          # Vi
          bindkey -M vicmd "k" history-substring-search-up
          bindkey -M vicmd "j" history-substring-search-down

          # Emacs and Vi
          for keymap in 'emacs' 'viins'; do
            bindkey "$terminfo[kcuu1]" history-substring-search-up
            bindkey "$terminfo[kcud1]" history-substring-search-down
          done

          unset keymap
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
              fortune -s ${toString config.xdg.dataHome}/fortunes all
              print
            fi

          } >&2
        '';

        shellAliases = {
          rm = "echo \"This is not the command you are looking for. trash or trash-put is better. Focus to use 'rm' with a prefix backslash.\"; false";

          lla = "ls -lAh";
          ecd = "emacs --daemon";
          ecq = "emacsclient -q -t -e \"(kill-emacs)\"";
          ec  = "emacsclient -n";
          ecc = "emacsclient -n -c";
          eCt = "emacsclient -t";
          eC  = "emacsclient";
          eCc = "emacsclient -c";

          _ = "sudo";
          b = "\${(z)BROWSER}";
          diffu = "diff --unified";
          e = "\${(z)VISUAL:-\${(z)EDITOR}}";
          p = "\${(z)PAGER}";
          po = "popd";
          pu = "pushd";
          sa = "alias | grep -i";
          d = "dirs -v";
          o = "xdg-open";
          l = "ls -1A";
          ll = "ls -lh";
          lr = "ll -R";
          la = "ll -A";
          lm = "la | \"$PAGER\"";
          lx = "ll -XB";
          lk = "ll -Sr";
          lt = "ll -tr";
          lc = "lt -c";
          lu = "lt -u";
          sl = "ls";
          rmi = "\${aliases[rm]:-rm} -i";
          mvi = "\${aliases[mv]:-mv} -i";
          cpi = "\${aliases[cp]:-cp} -i";
          lni = "\${aliases[ln]:-ln} -i";
          pbcopy = "xclip -selection clipboard -in";
          pbpaste = "xclip -selection clipboard -out";
          get = "curl --continue-at - --location --progress-bar --remote-name --remote-time";
          http-serve = "nix run nixpkgs.python3 -c python3 -m http.server";
        };
      };
    };

    xdg.dataFile = {
      "fortunes" = {
        source = with pkgs; symlinkJoin {
          name = "fortunes";
          paths = [ "${vonfryPackages.fortuneChinese}/share/fortunes"
                  ];
        };
        recursive = true;
      };
    };

    home = {
      activation.shellActivation =
        let
          sessions = config.home.sessionVariables;
          inherit (sessions) DOTFILES_DIR CLOUD_DIR PASSWD_DIR ORG_DIR CLONE_LIB;
          inherit (config.xdg) configHome;

          hasOrg = sessions ? "ORG_DIR";
          hasCloud = sessions ? "CLOUD_DIR";
          hasPasswd = sessions ? "PASSWD_DIR";

          emacsLocal = "${CLOUD_DIR}/dotfiles/config/emacs.d/local";
          linkOrg = optionalString (hasOrg && hasCloud) ''
            ! [ -h ${ORG_DIR} ] && $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${CLOUD_DIR}/dotfiles/orgmode ${ORG_DIR}
          '';
          linkEmacs = optionalString hasCloud ''
            if [ -d "${emacsLocal}" ]; then
              $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${emacsLocal}/* ${toString configHome}/emacs.d/local
            fi
          '';
          checkPasswd = optionalString (hasCloud && hasPasswd) ''
            $DRY_RUN_CMD mkdir -p ${CLONE_LIB} ${PASSWD_DIR}
            if ! [ -f ${PASSWD_DIR}/authinfo.gpg ]; then
              $DRY_RUN_CMD echo "please create authinfo.gpg file under ${PASSWD_DIR}"
              exit
            fi
          '';
          linkNormal = ''
            mkdir -p ${config.xdg.cacheHome} ~/.local

            if [ -z "${DOTFILES_DIR}"  ]; then
              $DRY_RUN_CMD echo "Config local file at first."
              exit -1
            fi

            ! [ -f ${toString configHome}/bg.png ] && ln -s ${pkgs.vonfryPackages.desktopBackground} ${toString configHome}/bg.png

            if ! [ -f ~/.face.icon ]; then
              cp ${pkgs.vonfryPackages.iconFace} .face.icon
              setfacl -m u:sddm:x ~/
              setfacl -m u:sddm:r ~/.face.icon
            fi
          '';
        in lib.hm.dag.entryAfter ["writeBoundary"]
          (concatStringsSep "\n" [ linkNormal linkOrg linkEmacs checkPasswd ]);

      packages = with pkgs; [
        zsh fzf jump
        trash-cli thefuck # tmux
        neofetch
        # lolcat
        asciinema

        zsh-completions
      ];
    };
  };
}
