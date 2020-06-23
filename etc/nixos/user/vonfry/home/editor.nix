{ ... }:

{
  # Use home.file instead of programs.<editor> due to I want to have a structure
  # config file for them.
  home.file = {
    ".config/emacs.d" = {
      source = ./files/emacs.d;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./files/nvim;
      recursive = true;
    };
    ".vimrc".source = ./files/vimrc;
  };
}
