# NixOS

## File Name

`<name>.nix`: file is under vcs.

`<name>.local.nix`: local file isn't under vcs using for current machine only,
and they areloaded by hard coding, which means they must exist.
Note: Please consider to use local dir at first. Other local file is only for
special using.  

`<name>.local.nix.example`: example file for local one, which isn't used in
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
- tools to enhance the original feature: fzf, thefuck, tmux, etc.
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

`**/local`: nix scripts are used in local, which are loaded by default but
different from `<name>.local.nix`, these files are optional.

## Packages

Most packages are installed for user, only some really useful packages are
installed in system, to keep minimal. 

### overlay

See [user/vonfry/overlay](./user/vonfry/overlay/readme.md)
