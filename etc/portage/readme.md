# portage

## Setup

In the setup files, I use `cp` to do this instead of `ln`. Because this is a global file for system. It is always
edited.

You can use `ln` instead of `cp`. And see [ignore edit](#ignore-version-control) to do changes.

## Ignore Version Control

If you want to make some changes only for yourself, you can use command `git update-index --assume-unchanged <PATH>`.

When you want to reset them, use `git update-index --no-assume-unchanged <PATH>`.

Or you can edit .git/info/exclude to do the same thing.
