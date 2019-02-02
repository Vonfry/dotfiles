# NixOS

## File Name

`<name>.nix`: file is under vcs.

`<name>.local.nix`: local file isn't under vcs using for current machine only.

`<name>.local.nix.example`: example file for local one, which isn't used in configuration but some of them are copied when setuping because of they are necessary.

`<name>`: Name is without point and only use lower camel case style.

Note: Local files don't load by default except some special ones, so you should import them by yourselves. It can make file content more clearful.

## Dir Structure

`./libs`: nix scripts are used in configure.

## Packages

Most packages are installed for user, only some really useful packages are installed in system, to keep minimal.

### Custom

See [user/vonfry/pkgs/custom](./user/vonfry/pkgs/custom/readme.md)
