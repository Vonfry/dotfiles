# dotfiles

These files are only for myself. I suggest those who want to use it that please think of it as a reference and don't use
it directly.

It contains developing environment and some test environment. So the setup file also can be used for server (without
services' configure), but there are a lot of things that the server doesn't need.

## System

- [x] macOS

- [ ] Gentoo - It is also testing, and without X11. See [todo](#todo)

- [ ] ~~NixOS~~ - See [below](#NixOS). old files by checking tag `develop/nixos` 

- [ ] ~~Fedora~~ - stop maintaining, old files by checking tag but I forget which one is.

### NixOS

~~I have tried it. The nix and nixos configuration are good designed. BUT! There are too many non-standard things, such as lib dir, if I want to install something without nix, it will be failed certainly because of the building time linking. The OS is too young. I will retry it after years.

Now, only use nix with a build tool on other system.~~

Rethinking again. And try it again! I find some surprising feature for nixos!

## command-line

- [x] zsh
- [x] ~~fish~~ - stop maintaining. old files by checking tag `develop/shell-fish` 

## Window Manager

- [ ] XMonad

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

### Reference

Here is a list of used mirror with this repo. Some things like `~/.cabal/config` which aren't contain in the repo should be set by yourself.

- [ ustc ] homebrew.git & homebrew-core & homebrew-cask & homebrew-bottle

- [ ustc ] Gentoo portage

- [ ustc ] pypi

- [ tuna ] hackage & stackage ( without `cabal`）

- [ tuna ] elpa

- [ tuna ] CRAN

- [ tuna ] rubygems

- [ tuna ] CTAN

# TODO

see :[todo.org](todo.org)

Now the most important thing is to use `lsp` instead of other completion tools. Some of them have done, but some not.

## Life

I use iTerm on mac and do anything on program with command line. And using ConEmu as terminal on windows.

Gentoo is a good linux distribution, we can control a lot of things in our system.

I use Omnifocus for GTD, fantastical for calander, Feedly for feeds.

Some of them are supported in my configure but I don't use them usually.

I only use org-mode to save todo in projects and feed for some update atom such as hackage and stackage.
