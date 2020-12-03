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
          path = "${toString config.xdg.configHome}/zsh/zsh_history";
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
          setopt complete_in_word
          setopt always_to_end
          setopt path_dirs
          setopt auto_menu
          setopt auto_list
          setopt auto_param_slash
          setopt extended_glob
          unsetopt menu_complete
          unsetopt flow_control

          zstyle ':completion::complete:*' use-cache on
          zstyle ':completion::complete:*' cache-path "${toString config.xdg.cacheHome}/zcompcache"

          # Group matches and describe.
          zstyle ':completion:*:*:*:*:*' menu select
          zstyle ':completion:*:matches' group 'yes'
          zstyle ':completion:*:options' description 'yes'
          zstyle ':completion:*:options' auto-description '%d'
          zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
          zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
          zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
          zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
          zstyle ':completion:*:default' list-prompt '%S%M matches%s'
          zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
          zstyle ':completion:*' group-name ""
          zstyle ':completion:*' verbose yes

          # Fuzzy match mistyped completions.
          zstyle ':completion:*' completer _complete _match _approximate
          zstyle ':completion:*:match:*' original only
          zstyle ':completion:*:approximate:*' max-errors 1 numeric

          # Increase the number of errors based on the length of the typed word. But make
          # sure to cap (at 7) the max-errors to avoid hanging.
          zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

          # Don't complete unavailable commands.
          zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

          # Array completion element sorting.
          zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

          # Directories
          zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
          zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
          zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
          zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
          zstyle ':completion:*' squeeze-slashes true

          # History
          zstyle ':completion:*:history-words' stop yes
          zstyle ':completion:*:history-words' remove-all-dups yes
          zstyle ':completion:*:history-words' list false
          zstyle ':completion:*:history-words' menu yes

          # Environment Variables
          zstyle ':completion::*:(-command-|export):*' fake-parameters ''${''${''${_comps[(I)-value-*]#*,}%%,*}:#-*-}

          # Populate hostname completion. But allow ignoring custom entries from static
          # */etc/hosts* which might be uninteresting.
          zstyle -a ':prezto:module:completion:*:hosts' etc-host-ignores '_etc_host_ignores'

          zstyle -e ':completion:*:hosts' hosts 'reply=(
            ''${=''${=''${=''${''${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
            ''${=''${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#''${_etc_host_ignores:+|''${(j:|:)~_etc_host_ignores}})*}
            ''${=''${''${''${''${(@M)''${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
          )'

          # Don't complete uninteresting users...
          zstyle ':completion:*:*:*:users' ignored-patterns \
            adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
            dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
            hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
            mailman mailnull mldonkey mysql nagios \
            named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
            operator pcap postfix postgres privoxy pulse pvm quagga radvd \
            rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

          # ... unless we really want to.
          zstyle '*' single-ignored show

          # Ignore multiple entries.
          zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
          zstyle ':completion:*:rm:*' file-patterns '*:all-files'

          # Kill
          zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
          zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
          zstyle ':completion:*:*:kill:*' menu yes select
          zstyle ':completion:*:*:kill:*' force-list always
          zstyle ':completion:*:*:kill:*' insert-ids single

          # Man
          zstyle ':completion:*:manuals' separate-sections true
          zstyle ':completion:*:manuals.(^1*)' insert-sections true

          # Media Players
          zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
          zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
          zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
          zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

          zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
          zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
          zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
          zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
          zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
          zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

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
          inherit (sessions) DOTFILES_DIR CLOUD_DIR ORG_DIR CLONE_LIB;
          inherit (config.xdg) configHome cacheHome;

          hasOrg = sessions ? "ORG_DIR";
          hasCloud = sessions ? "CLOUD_DIR";
          hasLib = sessions ? "CLONE_LIB";

          emacsLocal = "${CLOUD_DIR}/dotfiles/config/emacs.d/local";
          linkOrg = optionalString (hasOrg && hasCloud) ''
            ! [ -h ${ORG_DIR} ] && $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${CLOUD_DIR}/dotfiles/orgmode ${ORG_DIR}
          '';
          linkEmacs = optionalString hasCloud ''
            if [ -d "${emacsLocal}" ]; then
              $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${emacsLocal}/* ${toString configHome}/emacs.d/local
            fi
          '';
          makeLib = optionalString hasLib ''
            $DRY_RUN_CMD mkdir -p ${CLONE_LIB}
          '';
          linkNormal = ''
            mkdir -p ${toString cacheHome} ~/.local

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
          (concatStringsSep "\n" [ linkNormal linkOrg linkEmacs makeLib ]);

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
