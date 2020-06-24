{ pkgs, ... }:

let 
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
	    # export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs git hg kube)
	    name = "geometry-zsh/geometry";
	  }];
	};
	# TODO
	envExtra = ''
	'';
	initExtra = ''
	'';
	initExtraBeforeCompInit  = ''
	'';
	localVariables = ''
	'';
	loginExtra = ''
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
	};
      };
    };
  };
  confLinux = {
    programs = {
      htop = {
        enable = true;
	treeview = true;
      };
    }
  };
  confDarwin = {};
in conf // (if (!pkgs.stdenv.isDarwin) then confLinux else confDarwin);
