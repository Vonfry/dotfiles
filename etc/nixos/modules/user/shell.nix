{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;

in {
  config = mkIf cfg.enable {

    programs = {
      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [ "--cmd" "j" ];
      };

      thefuck = {
        enable = true;
        enableFishIntegration = true;
      };

      bash = {
        enable = true; # make some script can load hm-sessions.
      };

      starship = {
        enable = true;
        enableFishIntegration = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = true;
        changeDirWidgetCommand = "fd --type d";
        defaultCommand = "fd --type f";
        fileWidgetCommand = "fd --type f";
      };

      fish = {
        enable = true;
        shellInitLast = ''
          function set_terminal_title --on-event fish_prompt
            # Set the terminal title to the current directory or any custom string
            echo -ne "\e]0;(basename $PWD)\a"
          end

          function fish_greeting
            if type fortune >/dev/null 2>&1
                fortune -s ${toString config.xdg.dataHome}/fortunes all
            end
          end
        '';

        shellAliases = {
          rm = "echo \"This is not the command you are looking for. trash better. Focus to use 'rm' with commond\"; false";
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

          b = "$BROWSER";
          diffu = "diff --unified";
          e = "$EDITOR";
          p = "$PAGER";
          po = "popd";
          pu = "pushd";
          sa = "alias | grep -i";
          d = "dirs -v";
          o = "xdg-open";
          clipin = "xclip -selection clipboard -in";
          clipout = "xclip -selection clipboard -out";

          http-serve = "nix run 'nixpkgs#simple-http-server' --";

          gitu = "nix run 'nixpkgs#gitu'";

          asciinema = "nix run 'nixpkgs#asciinema'";
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
        trash-cli
      ];

      sessionPath = [ "~/.local/bin" ];
    };
  };
}
