# dotfiles

These files are only for myself. I suggest those who want to use it that please think of it as a reference and don't use
it directly.

It contains developing environment and some test environment. So the setup file also can be used for server (without
services' configure), but there are a lot of things that the server doesn't need.

## mirror

Becase of I'm in China, most of mirror is used with tuna or ustc by default.

Here is a list of used mirror with this repo. Some things like `~/.cabal/config` which aren't contain in the repo should be set by yourself.

- [ ustc ] homebrew.git & homebrew-core & homebrew-cask & homebrew-bottle
- [ ustc ] pypi
- [ tuna ] hackage & stackage ( without `cabal`)
- [ tuna ] elpa
- [ tuna ] CRAN
- [ tuna ] rubygems

## system

- [x] macOS

- [ ] Gentoo - It is also testing, and without X11. See [todo](#todo)

- [ ] NixOS - I'm trying it. Used possiblly is it or nix.

- [ ] ~~Fedora~~ - stop maintaining, You can check the old tag to take a look.

## command-line

- [x]  zsh
- [x]  ~~fish~~ - stop maintaining. You can check tag `develop/shell-fish` to use it. 

## window manager

- [ ] XMonad

## editor

- [x]  ~~Vim~~ stop maintaining. You can check tag `20180605.193` to use it. 
- [x]  Neovim 
- [x]  Emacs
Now I'm using ivy, the old helm config can check by tag `develop/emacs-helm`

## lang

- orgmode & latex
- C/C++ - clang/llvm
- Haskell - ghc & stack
- Lisp
- Ruby - chenv 
- R 
- Python3 
- Web - js, html, css/sass, ts

The other languages are also supposed in system and editor, but they aren't used usally so they haven't a complete
developing environment.

# TODO

see :[todo.org](todo.org)

Now the most important thing is to use `lsp` instead of other completion tools. Some of them have done, but some not.

## life

I use iTerm on mac and do anything on program with command line. And using ConEmu as terminal on windows.

Gentoo is a good linux distribution, we can control a lot of things in our system.

I use Omnifocus for GTD, fantastical for calander, Feedly for feeds.

Some of them are supported in my configure but I don't use them usually.

I only use org-mode to save todo in projects and feed for some update atom such as hackage and stackage.
