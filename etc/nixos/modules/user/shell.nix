{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    vonfry.development.emacs.excludeModules =
      let sessions = config.home.sessionVariables;
          noLedger = ! sessions ? LEDGER_FILE;
      in optional noLedger "misc/ledger";

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

          export LESS_TERMCAP_mb=$'\E[01;31m'
          export LESS_TERMCAP_md=$'\E[01;31m'
          export LESS_TERMCAP_me=$'\E[0m'
          export LESS_TERMCAP_se=$'\E[0m'
          export LESS_TERMCAP_so=$'\E[00;47;30m'
          export LESS_TERMCAP_ue=$'\E[0m'
          export LESS_TERMCAP_us=$'\E[01;32m'

          source ${zsh-fzf-tab}/fzf-tab.plugin.zsh
          source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
          source ${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
          source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
          # ${zsh-completions}

          eval "$(zoxide init zsh)"
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

        shellAliases =
          let
            _git_log_medium_format="%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B";
            _git_log_oneline_format="%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n";
            _git_log_brief_format="%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n";
            _git_status_ignore_submodules="none";
          in {
            rm = "echo \"This is not the command you are looking for. trash or trash-put is better. Focus to use 'rm' with a prefix backslash.\"; false";

            lla = "ls -lAh";
            ecd = "emacs --daemon";
            ecq = "emacsclient -q -t -e \"(kill-emacs)\"";
            ec  = "emacsclient -n";
            ecc = "emacsclient -n -c";
            eCt = "emacsclient -t";
            ect = "eCt";
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

            # Git
            g = "git";

            # Branch (b)
            gb  = "git branch";
            gba = "git branch --all --verbose";
            gbc = "git checkout -b";
            gbd = "git branch --delete";
            gbD = "git branch --delete --force";
            gbl = "git branch --verbose";
            gbL = "git branch --all --verbose";
            gbm = "git branch --move";
            gbM = "git branch --move --force";
            gbr = "git branch --move";
            gbR = "git branch --move --force";
            gbs = "git show-branch";
            gbS = "git show-branch --all";
            gbv = "git branch --verbose";
            gbV = "git branch --verbose --verbose";
            gbx = "git branch --delete";
            gbX = "git branch --delete --force";

            # Commit (c)
            gc   = "git commit --verbose";
            gca  = "git commit --verbose --all";
            gcm  = "git commit --message";
            gcS  = "git commit -S --verbose";
            gcSa = "git commit -S --verbose --all";
            gcSm = "git commit -S --message";
            gcam = "git commit --all --message";
            gco  = "git checkout";
            gcO  = "git checkout --patch";
            gcf  = "git commit --amend --reuse-message HEAD";
            gcSf = "git commit -S --amend --reuse-message HEAD";
            gcF  = "git commit --verbose --amend";
            gcSF = "git commit -S --verbose --amend";
            gcp  = "git cherry-pick --ff";
            gcP  = "git cherry-pick --no-commit";
            gcr  = "git revert";
            gcR  = "git reset \"HEAD^\"";
            gcs  = "git show";
            gcsS = "git show --pretty=short --show-signature";
            gcl  = "git-commit-lost";
            gcy  = "git cherry -v --abbrev";
            gcY  = "git cherry -v";

            # Conflict (C)
            gCl = "git --no-pager diff --name-only --diff-filter=U";
            gCa = "git add $(gCl)";
            gCe = "git mergetool $(gCl)";
            gCo = "git checkout --ours --";
            gCO = "gCo $(gCl)";
            gCt = "git checkout --theirs --";
            gCT = "gCt $(gCl)";

            # Data (d)
            gd  = "git ls-files";
            gdc = "git ls-files --cached";
            gdx = "git ls-files --deleted";
            gdm = "git ls-files --modified";
            gdu = "git ls-files --other --exclude-standard";
            gdk = "git ls-files --killed";
            gdi = "git status --porcelain --short --ignored | sed -n \"s/^!! //p\"";

            # Fetch (f)
            gf   = "git fetch";
            gfa  = "git fetch --all";
            gfc  = "git clone";
            gfcr = "git clone --recurse-submodules";
            gfm  = "git pull";
            gfma = "git pull --autostash";
            gfr  = "git pull --rebase";
            gfra = "git pull --rebase --autostash";

            # Flow (F)
            gFi = "git flow init";
            gFf = "git flow feature";
            gFb = "git flow bugfix";
            gFl = "git flow release";
            gFh = "git flow hotfix";
            gFs = "git flow support";

            gFfl = "git flow feature list";
            gFfs = "git flow feature start";
            gFff = "git flow feature finish";
            gFfp = "git flow feature publish";
            gFft = "git flow feature track";
            gFfd = "git flow feature diff";
            gFfr = "git flow feature rebase";
            gFfc = "git flow feature checkout";
            gFfm = "git flow feature pull";
            gFfx = "git flow feature delete";

            gFbl = "git flow bugfix list";
            gFbs = "git flow bugfix start";
            gFbf = "git flow bugfix finish";
            gFbp = "git flow bugfix publish";
            gFbt = "git flow bugfix track";
            gFbd = "git flow bugfix diff";
            gFbr = "git flow bugfix rebase";
            gFbc = "git flow bugfix checkout";
            gFbm = "git flow bugfix pull";
            gFbx = "git flow bugfix delete";

            gFll = "git flow release list";
            gFls = "git flow release start";
            gFlf = "git flow release finish";
            gFlp = "git flow release publish";
            gFlt = "git flow release track";
            gFld = "git flow release diff";
            gFlr = "git flow release rebase";
            gFlc = "git flow release checkout";
            gFlm = "git flow release pull";
            gFlx = "git flow release delete";

            gFhl = "git flow hotfix list";
            gFhs = "git flow hotfix start";
            gFhf = "git flow hotfix finish";
            gFhp = "git flow hotfix publish";
            gFht = "git flow hotfix track";
            gFhd = "git flow hotfix diff";
            gFhr = "git flow hotfix rebase";
            gFhc = "git flow hotfix checkout";
            gFhm = "git flow hotfix pull";
            gFhx = "git flow hotfix delete";

            gFsl = "git flow support list";
            gFss = "git flow support start";
            gFsf = "git flow support finish";
            gFsp = "git flow support publish";
            gFst = "git flow support track";
            gFsd = "git flow support diff";
            gFsr = "git flow support rebase";
            gFsc = "git flow support checkout";
            gFsm = "git flow support pull";
            gFsx = "git flow support delete";

            # Grep (g)
            gg  = "git grep";
            ggi = "git grep --ignore-case";
            ggl = "git grep --files-with-matches";
            ggL = "git grep --files-without-matches";
            ggv = "git grep --invert-match";
            ggw = "git grep --word-regexp";

            # Index (i)
            gia = "git add";
            giA = "git add --patch";
            giu = "git add --update";
            gid = "git diff --no-ext-diff --cached";
            giD = "git diff --no-ext-diff --cached --word-diff";
            gii = "git update-index --assume-unchanged";
            giI = "git update-index --no-assume-unchanged";
            gir = "git reset";
            giR = "git reset --patch";
            gix = "git rm -r --cached";
            giX = "git rm -rf --cached";

            # Log (l)
            gl  = "git log --topo-order --pretty=format:\"${_git_log_medium_format}\"";
            gls = "git log --topo-order --stat --pretty=format:\"${_git_log_medium_format}\"";
            gld = "git log --topo-order --stat --patch --full-diff --pretty=format:\"${_git_log_medium_format}\"";
            glo = "git log --topo-order --pretty=format:\"${_git_log_oneline_format}\"";
            glg = "git log --topo-order --graph --pretty=format:\"${_git_log_oneline_format}\"";
            glb = "git log --topo-order --pretty=format:\"${_git_log_brief_format}\"";
            glc = "git shortlog --summary --numbered";
            glS = "git log --show-signature";

            # Merge (m)
            gm  = "git merge";
            gmC = "git merge --no-commit";
            gmF = "git merge --no-ff";
            gma = "git merge --abort";
            gmt = "git mergetool";

            # Push (p)
            gp  = "git push";
            gpf = "git push --force-with-lease";
            gpF = "git push --force";
            gpa = "git push --all";
            gpA = "git push --all && git push --tags";
            gpt = "git push --tags";
            gpc = "git push --set-upstream origin \"$(git-branch-current 2> /dev/null)\"";
            gpp = "git pull origin \"$(git-branch-current 2> /dev/null)\" && git push origin \"$(git-branch-current 2> /dev/null)\"";

            # Rebase (r)
            gr  = "git rebase";
            gra = "git rebase --abort";
            grc = "git rebase --continue";
            gri = "git rebase --interactive";
            grs = "git rebase --skip";

            # Remote (R)
            gR  = "git remote";
            gRl = "git remote --verbose";
            gRa = "git remote add";
            gRx = "git remote rm";
            gRm = "git remote rename";
            gRu = "git remote update";
            gRp = "git remote prune";
            gRs = "git remote show";
            gRb = "git-hub-browse";

            # Stash (s)
            gs  = "git stash";
            gsa = "git stash apply";
            gsx = "git stash drop";
            gsX = "git-stash-clear-interactive";
            gsl = "git stash list";
            gsL = "git-stash-dropped";
            gsd = "git stash show --patch --stat";
            gsp = "git stash pop";
            gsr = "git-stash-recover";
            gss = "git stash save --include-untracked";
            gsS = "git stash save --patch --no-keep-index";
            gsw = "git stash save --include-untracked --keep-index";

            # Submodule (S)
            gS  = "git submodule";
            gSa = "git submodule add";
            gSf = "git submodule foreach";
            gSi = "git submodule init";
            gSI = "git submodule update --init --recursive";
            gSl = "git submodule status";
            gSm = "git-submodule-move";
            gSs = "git submodule sync";
            gSu = "git submodule foreach git pull origin master";
            gSx = "git-submodule-remove";

            # Tag (t)
            gt  = "git tag";
            gtl = "git tag -l";
            gts = "git tag -s";
            gtv = "git verify-tag";

            # Working Copy (w)
            gws = "git status --ignore-submodules=${_git_status_ignore_submodules} --short";
            gwS = "git status --ignore-submodules=${_git_status_ignore_submodules}";
            gwd = "git diff --no-ext-diff";
            gwD = "git diff --no-ext-diff --word-diff";
            gwr = "git reset --soft";
            gwR = "git reset --hard";
            gwc = "git clean -n";
            gwC = "git clean -f";
            gwx = "git rm -r";
            gwX = "git rm -rf";

            # Docker
            dk    = "docker";
            dka   = "docker attach";
            dkb   = "docker build";
            dkd   = "docker diff";
            dkdf  = "docker system df";
            dke   = "docker exec";
            dkE   = "docker exec -it";
            dkh   = "docker history";
            dki   = "docker images";
            dkin  = "docker inspect";
            dkim  = "docker import";
            dkk   = "docker kill";
            dkl   = "docker logs";
            dkli  = "docker login";
            dklo  = "docker logout";
            dkls  = "docker ps";
            dkp   = "docker pause";
            dkP   = "docker unpause";
            dkpl  = "docker pull";
            dkph  = "docker push";
            dkps  = "docker ps";
            dkpsa = "docker ps -a";
            dkr   = "docker run";
            dkR   = "docker run -it --rm";
            dkRe  = "docker run -it --rm --entrypoint /bin/bash";
            dkRM  = "docker system prune";
            dkrm  = "docker rm";
            dkrmi = "docker rmi";
            dkrn  = "docker rename";
            dks   = "docker start";
            dkS   = "docker restart";
            dkss  = "docker stats";
            dksv  = "docker save";
            dkt   = "docker tag";
            dktop = "docker top";
            dkup  = "docker update";
            dkv   = "docker version";
            dkw   = "docker wait";
            dkx   = "docker stop";

            ## Container (C)
            dkC    = "docker container";
            dkCa   = "docker container attach";
            dkCcp  = "docker container cp";
            dkCd   = "docker container diff";
            dkCe   = "docker container exec";
            dkCin  = "docker container inspect";
            dkCk   = "docker container kill";
            dkCl   = "docker container logs";
            dkCls  = "docker container ls";
            dkCp   = "docker container pause";
            dkCpr  = "docker container prune";
            dkCrn  = "docker container rename";
            dkCS   = "docker container restart";
            dkCrm  = "docker container rm";
            dkCr   = "docker container run";
            dkCR   = "docker container run -it --rm";
            dkCRe  = "docker container run -it --rm --entrypoint /bin/bash";
            dkCs   = "docker container start";
            dkCss  = "docker container stats";
            dkCx   = "docker container stop";
            dkCtop = "docker container top";
            dkCP   = "docker container unpause";
            dkCup  = "docker container update";
            dkCw   = "docker container wait";

            ## Image (I)
            dkI   = "docker image";
            dkIb  = "docker image build";
            dkIh  = "docker image history";
            dkIim = "docker image import";
            dkIin = "docker image inspect";
            dkIls = "docker image ls";
            dkIpr = "docker image prune";
            dkIpl = "docker image pull";
            dkIph = "docker image push";
            dkIrm = "docker image rm";
            dkIsv = "docker image save";
            dkIt  = "docker image tag";

            ## Volume (V)
            dkV   = "docker volume";
            dkVin = "docker volume inspect";
            dkVls = "docker volume ls";
            dkVpr = "docker volume prune";
            dkVrm = "docker volume rm";

            ## Network (N)
            dkN   = "docker network";
            dkNs  = "docker network connect";
            dkNx  = "docker network disconnect";
            dkNin = "docker network inspect";
            dkNls = "docker network ls";
            dkNpr = "docker network prune";
            dkNrm = "docker network rm";

            ## System (Y)
            dkY   = "docker system";
            dkYdf = "docker system df";
            dkYpr = "docker system prune";

            ## Stack (K)
            dkK   = "docker stack";
            dkKls = "docker stack ls";
            dkKps = "docker stack ps";
            dkKrm = "docker stack rm";

            ## Swarm (W)
            dkW = "docker swarm";

            ## CleanUp (rm)
            # Clean up exited containers (docker < 1.13)
            dkrmC = "docker rm $(docker ps -qaf status=exited)";
            # Clean up dangling images (docker < 1.13)
            dkrmI = "docker rmi $(docker images -qf dangling=true)";
            # Clean up dangling volumes (docker < 1.13)
            dkrmV = "docker volume rm $(docker volume ls -qf dangling=true)";


            # Docker Machine (m)
            dkm   = "docker-machine";
            dkma  = "docker-machine active";
            dkmcp = "docker-machine scp";
            dkmin = "docker-machine inspect";
            dkmip = "docker-machine ip";
            dkmk  = "docker-machine kill";
            dkmls = "docker-machine ls";
            dkmpr = "docker-machine provision";
            dkmps = "docker-machine ps";
            dkmrg = "docker-machine regenerate-certs";
            dkmrm = "docker-machine rm";
            dkms  = "docker-machine start";
            dkmsh = "docker-machine ssh";
            dkmst = "docker-machine status";
            dkmS  = "docker-machine restart";
            dkmu  = "docker-machine url";
            dkmup = "docker-machine upgrade";
            dkmv  = "docker-machine version";
            dkmx  = "docker-machine stop";

            # Docker Compose (c)
            dkc   = "docker-compose";
            dkcb  = "docker-compose build";
            dkcB  = "docker-compose build --no-cache";
            dkcd  = "docker-compose down";
            dkce  = "docker-compose exec";
            dkck  = "docker-compose kill";
            dkcl  = "docker-compose logs";
            dkcls = "docker-compose ps";
            dkcp  = "docker-compose pause";
            dkcP  = "docker-compose unpause";
            dkcpl = "docker-compose pull";
            dkcph = "docker-compose push";
            dkcps = "docker-compose ps";
            dkcr  = "docker-compose run";
            dkcR  = "docker-compose run --rm";
            dkcrm = "docker-compose rm";
            dkcs  = "docker-compose start";
            dkcsc = "docker-compose scale";
            dkcS  = "docker-compose restart";
            dkcu  = "docker-compose up";
            dkcU  = "docker-compose up -d";
            dkcv  = "docker-compose version";
            dkcx  = "docker-compose stop";

            # Perl
            pl  = "perl";
            pld = "perldoc";
            ple = "perl -wlne";
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
          emacsPrivate = "${CLOUD_DIR}/dotfiles/config/emacs.d/private";
          linkOrg = optionalString (hasOrg && hasCloud) ''
            ! [ -h ${ORG_DIR} ] && $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${CLOUD_DIR}/dotfiles/orgmode ${ORG_DIR}
          '';
          linkEmacs = optionalString hasCloud ''
            if [ -d "${emacsLocal}" ]; then
              $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${emacsLocal}/* ${toString configHome}/emacs.d/local
            fi
            if [ -d "${emacsPrivate}" ]; then
              $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${emacsPrivate}/* ${toString configHome}/emacs.d/modules/private
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
        zsh fzf zoxide
        trash-cli thefuck # tmux
        neofetch
        asciinema

        # zsh-completions
      ];
    };
  };
}
