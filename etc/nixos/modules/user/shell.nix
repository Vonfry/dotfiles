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
        enableCompletion = true;
        dotDir = ".config/zsh";
        plugins = with pkgs; [{
          name = "prezto";
          file = "init.zsh";
          src = fetchFromGitHub {
            owner = "Vonfry";
            repo = "prezto";
            rev = "fa7acd43d9f94d69af24ea36097a7dd32db90f2a";
            sha256 = "12ps37z7kzihas0dr39fwmxx94nfm7f2bvlsn22ysjh8migpgjjs";
            fetchSubmodules = true;
          };
        } {
          name = "git-open";
          src = fetchFromGitHub {
            owner = "paulirish";
            repo = "git-open";
            rev = "14fdf5c96e30e89b84504d513a0311b3f712cee0";
            sha256 = "073wpm4gbgsa110js487zcwgsclczimplrcsl7fxqrrbcyf26wq5";
          };
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
          rm = "echo \"This is not the command you are looking for. trash or trash-put is better. Focus to use 'rm' with a prefix backslash.\"; false";

          lla = "ls -lAh";
          ecd = "emacs --daemon";
          ecq = "emacsclient -q -t -e \"(kill-emacs)\"";
          ec  = "emacsclient -n";
          ecc = "emacsclient -n -c";
          eCt = "emacsclient -t";
          eC  = "emacsclient";
          eCc = "emacsclient -c";
        };
      };
    };

    home = {
      file = {
        "${config.programs.zsh.dotDir}/.zpreztorc".source = ./files/zsh/zpreztorc;
      };

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
      ];
    };
  };
}
