# Custom

Some custom packages installed in global environment.

## Directory Structation

Two level strutation: `./<categories>/<softerware>/<files for drv>`

Categories' naming use gentoo package as reference. 

Each custom package is saved into an dir though here is only one file.

## Top level dir

[default.nix](./default.nix): Collection for exporting drv with nixpkgs.

[overlay.nix](./overlay.nix): Return a overlay function, but I don't use it.

## Package dir

build.nix: A drv without any arguments. This file will import nixpkgs by manual instead of passing in nixos configuration or others.

default.nix: A function with arguments from nixpkgs which return a drv. This is the main file to be called in build.nix and

## Update

You know nix-env don't automaticlly update packages in a custom package without version, version must be configured used to update packages. 

But, nixos-rebuild uses nix-build, not nix-env to update configuration, so every custom packages define in configuration will be rebuilt which will casual upgrading.

# Thinking

Why do I make custom packages independent from nixos configuration, though I use them in nixos only?

First, global or a user's overlay is not a good idea. I only use these custom package in shell by myself, which are not necessary for other packages, using a global overlay such as for python may pollute global space. Secondly, rename package instead of overriding nixpkgs can be done, but I insteall the packages from configuration files or using a shell script instead of nix-env, so it is unnecessary for me.
