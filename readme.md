# dotfiles

These files are only for myself. I suggest those who want to use it that please
think of it as a reference and don't use
it directly.

It contains developing environment and some test environment. So the setup file
also can be used for server (without
services' configure), but there are a lot of things that the server doesn't need.

## Tags

Besides release tags, here are some tags are used with perfix for other proposes.

### deprecated 

Some feature are not used with time going. I add a tag in the last commit
supposed them. All of them are started with `deprecated`

### mark

The topic is not deprecated, but it is not the default one in config.

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

- [X] ~~xterm~~
- [ ] ~~termonad~~ - Its most feature can be done in xmonad.
- [X] alacritty - A good term with gpu, but having some problem on my machine.

## Colorscheme

Both solarized and dracula are terrific, so I install both and switch theme by
mood. But I use dracula as the default one, becasue it use the color which I
love.

## Editor

- [x] ~~Vim~~
- [x] Neovim
- [x] Emacs

## Lang

- orgmode & latex
- C/C++ - clang/llvm
- Haskell - ghc & cabal ( without stack ) & nix
- Coq
- Rust
- ~~Lisp~~
- Ruby
- ~~R~~
- Python3
- ~~Web - js, html, css/sass, ts~~

The other languages are also supposed in system and editor, but they aren't used
usally so they haven't a complete
developing environment.

## Mirror

A mirror can help us to get resources quickly. But it is unstable. Only using
them when the network is bad.

# TODO

see: [todo.org](todo.org)

## Life

I use iTerm on mac and do anything on program with command line. ~~And using
ConEmu as terminal on windows.~~

NixOS and Gentoo are good linux distributions, we can control a lot of things in
our system. I'm mainly using NixOS now, which isn't only a system but also a
kind of thinking. Further more, Nix is a awesome build tools.

Zoho is a interesting mail suppiler. On macOS, Fantastical is a beautiful 
calander. On Linux, I use emacs for mail(mu4e), newsreader(gnus), rss(elfeed)
and other things. Using gnus for mail is different from other tools schu as 
mu4e, you can check a description [here](https://www.gnu.org/software/emacs/manual/html_node/gnus/Mail-in-a-Newsreader.html#Mail-in-a-Newsreader). It is not fit for me, and the reason for rss.
I may switch to it someday if gnus is supported with async. 
EBDB is a good contacts in emacs. Calender? Just org agenda.

I use org-mode to do GTD, diary and notes. And capturing web by pdf, which is not 
easy like evernote, but I like it. Some website use w3m with org for capturing.
