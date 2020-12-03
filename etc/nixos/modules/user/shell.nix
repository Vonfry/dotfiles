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
              fortune -s ${config.home.sessionVariables.CLONE_LIB}/fortunes/data all
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

    home = {
      activation.shellActivation =
        let
          sessions = config.home.sessionVariables;
        in with sessions; lib.hm.dag.entryAfter ["writeBoundary"] (concatStringsSep "\n" [
          (''
             mkdir -p ${config.xdg.cacheHome} ~/.local
             if [ -z "${DOTFILES_DIR}"  ]; then
               $DRY_RUN_CMD echo "file is copied, please edit it(${toString ./local/session.nix}). Then prepare for cloud files. "
               exit -1
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
          '')
          (optionalString (sessions ? "ORG_DIR" && sessions ? "CLOUD_DIR") ''
            ! [ -h ${ORG_DIR} ] && $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${CLOUD_DIR}/dotfiles/orgmode ${ORG_DIR}
          '')
          (let emacsLocal = "${CLOUD_DIR}/dotfiles/config/emacs.d/local";
           in optionalString (sessions ? "CLOUD_DIR") ''
            if [ -d "${emacsLocal}" ]; then
              $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${emacsLocal}/* ${toString config.xdg.configHome}/emacs.d/local
            fi
          '' )
          (optionalString (sessions ? "CLOUD_DIR" && sessions ? "PASSWD_DIR") ''
            $DRY_RUN_CMD mkdir -p ${CLONE_LIB} ${PASSWD_DIR}
            if ! [ -f ${PASSWD_DIR}/authinfo.gpg ]; then
              $DRY_RUN_CMD echo "please create authinfo.gpg file under ${PASSWD_DIR}"
              exit
            fi
          '')
        ]);

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
