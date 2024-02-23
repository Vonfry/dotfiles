{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;

  sessionVariables = config.home.sessionVariables;

  hasLedger = sessionVariables ? LEDGER_FILE;

  _git_log_medium_format="%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B";
  _git_log_oneline_format="%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n";
  _git_log_brief_format="%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n";
  _git_status_ignore_submodules="none";
in {
  config = mkIf cfg.enable {
    vonfry.development.emacs.excludeModules = optional (!hasLedger) "misc/ledger";

    warnings = optional (!hasLedger) "ledger file isn't set, so emacs module is disabled.";

    programs = {
      zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [ "--cmd j" ];
      };

      bash.enable = true; # make some script can load hm-sessions.

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
        enableCompletion = false;
        defaultKeymap = "emacs";

        localVariables = {
          WORDCHARS = "*?_-.[]~&;!#$%^(){}<>";
        };

        initExtra = with pkgs; ''
          setopt nomatch
          setopt extended_glob
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

          if [ -f "''${ZDOTDIR:-~}/.p10k.zsh" ]; then
            source ''${ZDOTDIR:-~}/.p10k.zsh
          fi
          source ${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
          source ${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
          source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
          source ${zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
          # ${zsh-completions}

          eval $(thefuck --alias)

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

          function set_win_title() {
            echo -ne "\033]0; shell: $(basename "$PWD") \007"
          }
          precmd_functions+=(set_win_title)
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
          rm = "echo \"This is not the command you are looking for. trash better. Focus to use 'rm' with a prefix backslash.\"; false";
          rt = "trash-put";
          rl = "trash-list";
          re = "trash-empty";
          rd = "trash-rm";
          rr = "trash-restore";

          tree = "lsd --tree";

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
          rmi = "\${aliases[rm]:-rm} -i";
          mvi = "\${aliases[mv]:-mv} -i";
          cpi = "\${aliases[cp]:-cp} -i";
          lni = "\${aliases[ln]:-ln} -i";
          pbcopy = "xclip -selection clipboard -in";
          pbpaste = "xclip -selection clipboard -out";
          get = "curl --continue-at - --location --progress-bar --remote-name --remote-time";
          http-serve = "nix run 'sys#simple-http-server' --";

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
      packages = with pkgs; [
        trash-cli thefuck
        asciinema
        nix-zsh-completions # because we disable zsh.enableCompletion
      ];

      sessionPath = [ "~/.local/bin" ];
    };
  };
}
