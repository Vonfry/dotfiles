# dotfiles

These files are only for myself. I suggest those who want to use it that please think of it as a reference and don't use
it directly.

It contains developing environment and some test environment. So the setup file also can be used for server (without
services' configure), but there are a lot of things that the server doesn't need.

## System

- [x] macOS

- [x] NixOS - See [nixos readme](./etc/nixos/readme.md). 

- [ ] Gentoo - It is also testing, and without X11. See [todo](#todo)

- [ ] ~~Fedora~~ - stop maintaining, old files by checking tag but I forget which one is.

## command-line

- [x] zsh
- [x] ~~fish~~ - stop maintaining. old files by checking tag `develop/shell-fish` 

## Window Manager

- [x] XMonad

## Editor

- [x] ~~Vim~~ stop maintaining. old files by checking tag `develop/vim` 
- [x] Neovim 
- [x] Emacs

      Now I'm using ivy, the old helm config can check by tag `develop/emacs-helm`

## Lang

- orgmode & latex
- C/C++ - clang/llvm
- Haskell - ghc & stack
- ~~Lisp~~
- Ruby - chenv 
- ~~R~~
- Python3 
- Web - js, html, css/sass, ts

The other languages are also supposed in system and editor, but they aren't used usally so they haven't a complete
developing environment.

## Mirror

A mirror can help us to get resources quickly. But it is unstable. Only using them when the network is bad.

Checkout `develop/mirrors` to see an example.

# TODO

see :[todo.org](todo.org)

## Life

I use iTerm on mac and do anything on program with command line. And using ConEmu as terminal on windows.

Gentoo is a good linux distribution, we can control a lot of things in our system.

I use Omnifocus for GTD, fantastical for calander, Feedly for feeds.

Some of them are supported in my configure but I don't use them usually.

I only use org-mode to save todo in projects and feed for some update atom such as hackage and stackage.
