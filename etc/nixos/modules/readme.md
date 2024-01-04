# Vonfry Modules

## File Name

`<name>.nix`: file is under vcs.

`<name>.nix.example`: example file for local one, which isn't used in
configuration but some of them are copied when setuping because of they are
necessary.

`<name>`: Name is without point and only use lower camel case style.

Note: Local files don't load by default except some special ones, so you should
import them by yourselves. It can make file content more clearful.

## File Content

### base
- nix and system configuration: nixpkgs, log, exfat, etc.
- basic tools: zip, interpreter, htop, etc.

### development
- editor, lib, compiler, vcs, etc.

### net
- basic network tools: mail, browser, curl, wget, etc.
- tools relative to net self: iftop, wireshark, etc.

### shell
- shell own configuration
- tools to enhance the original feature: fzf, thefuck, etc.
- only play in terminal or with terminal self: neofetch, asciinema, etc.

### x
- window c/s
- windows manager
- tools effect on it: notify, tray, etc.

### application
NB: none of above and it is only for each user.

- applications on a topic: music, file manager, video, etc.

### misc
- trival subjects
- none of above

## Dir Structure

All dirs is named as singular word, which represents a category.

`./lib`: nix scripts are used in configure.

## Packages

Most packages are installed for user, only some really useful packages are
installed in system, to keep minimal.

### overlay

See [user/vonfry/overlay](./user/vonfry/overlay/readme.md)

## Home-manager

Some features in home-manager are duplicated with NixOS and the NixOS ones are
used, specially for xsession and nixpkgs. Home-manager is designed for private
computer, so no compatible configs are coded.
