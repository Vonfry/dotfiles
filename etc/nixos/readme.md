# NixOS

All my config is under [./modules](./modules). Use the module and customize what
you want.

## Usage

Take a look at [./configuration.nix.example](./configuration.nix.example). The
example also can be taken as a reference for `home.nix` when importing
[./modules/user/home.nix](./modules/user/home.nix) into home-manager modules.

## Local file

`local` is used for private or local files. Other files' path can be used as
well with `git update-index --assume-unchanged <file-list>` or
`git update-index --skip-worktree <file-list>`.
