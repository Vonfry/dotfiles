# dotfiles

These files are only for myself. I suggest those who want to use it that please think of it as a reference and don't use
it directly.

It contains developing environment and some test environment. So the setup file also can be used for server (without
services' configure), but there are a lot of things that the server doesn't need.

## DEPRECATED Tag 

Some feature are not used with time going. I add a tag in the last commit
supposed them. All of them are started with `deprecated`


## System

- [x] macOS

- [x] NixOS - See [nixos readme](./etc/nixos/readme.md). 

- [ ] ~~Gentoo - It is also testing, and without X11. See [todo](#todo)~~

- [ ] ~~Fedora~~ - stop maintaining, old files by checking tag but I forget which one is.

## command-line

- [x] zsh
- [x] ~~fish~~ 

## Window Manager

- [x] XMonad

### Term

- [X] xterm
- [ ] ~~termonad~~ - Its most feature can be done in xmonad. 
- [ ] alacritty - A good term with gpu, but its config file contains too many
    options, such as arrow keys and xterm is enough for me. 

## Editor

- [x] ~~Vim~~ 
- [x] Neovim 
- [x] Emacs

## Lang

- orgmode & latex
- C/C++ - clang/llvm
- Haskell - ghc & cabal ( without stack ) & nix
- ~~Lisp~~
- Ruby - chenv 
- Rust
- ~~R~~
- Python3 
- ~~Web - js, html, css/sass, ts~~

The other languages are also supposed in system and editor, but they aren't used usally so they haven't a complete
developing environment.

## Mirror

A mirror can help us to get resources quickly. But it is unstable. Only using them when the network is bad.

# TODO

see :[todo.org](todo.org)

## Life

I use iTerm on mac and do anything on program with command line. And using ConEmu as terminal on windows.

NixOS and Gentoo are good linux distributions, we can control a lot of things in our system. I'm mainly using NixOS now, which isn't only a system but also a kind of thinking.

I use Omnifocus for GTD, fantastical for calander, Feedly for feeds.  
Some of them have another tools supported in my configure but I don't use them usually.

I only use org-mode to save todo in projects and feed for some update atom such as hackage.
