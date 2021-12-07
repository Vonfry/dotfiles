# Custom

Some custom packages installed in global environment.

## Directory Structation

Reference nixpkgs' directories.

## Top level dir

[default.nix](./default.nix): Collection for exporting drv with nixpkgs. It is an overlay.

## Update

You know nix-env don't automaticlly update packages in a custom package without version, version must be configured used to update packages.

But, nixos-rebuild uses nix-build, not nix-env to update configuration, so every custom packages define in configuration will be rebuilt which will casual upgrading.

# Thinking

Why do I make custom packages independent from nixos configuration, though I use them in nixos only?

First, global or a user's overlay is not a good idea. I only use these custom package in shell by myself, which are not necessary for other packages, using a global overlay such as for python may pollute global space. Secondly, rename package instead of overriding nixpkgs can be done, but I insteall the packages from configuration files or using a shell script instead of nix-env, so it is unnecessary for me.
