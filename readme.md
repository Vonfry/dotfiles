# dotfiles

These files are only for myself. I suggest those who want to use it to take
it as a reference instead of using it directly.

It contains developing and testing environment. Therefore the setup file
also can be used for server (without services' configure), but there are a lot
of things which are unnecessary.

## Tags

Besides release tags, here are some tags used with perfix for other proposing.

### deprecated

Some features are not used with time going. I add a tag in the last commit
supporting them. All of them are started with `deprecated`.

### mark

The topic is not deprecated, but it is not the default one and may be useless.

## System

- [x] ~~macOS~~

- [x] NixOS :: See [nixos readme](./etc/nixos/readme.md) and [flake.nix](./etc/nixos/flake.nix).

- [ ] ~~Gentoo~~ :: It is also testing, and without X11. See [todo](#todo)

- [ ] ~~Fedora :: stop maintaining, old files by checking tag but I forget which one is.~~

NixOS and Gentoo are good linux distributions, we can control a lot of
things in our system. I'm mainly using **NixOS** now, which isn't only a system
but also a kind of thinking. Further more, Nix is a awesome building tool.

Fedora/debain is simple for servers or public/share machines.

## command-line

- [x] ~~zsh~~
- [x] ~~fish~~
- [x] eshell

I'm using emacs, and eshell can intergal all emacs lisp features.
Although I cannot use TUI any longer, there are many alternatives in GUI or
emacs.

## Window Manager

- [x] XMonad

### Term

- [X] ~~xterm~~
- [ ] ~~termonad :: Its most feature can be done in xmonad.~~
- [X] ~~alacritty~~ :: A good term with gpu. ~~but having some problem on my machine.~~

Emacs is a shell as well, why not using eshell?

## Colorscheme

Both solarized and dracula are terrific, so I install both and switch theme by
mood. But I use dracula as the default one, becasue it uses the color which I
love.

## Editor

- [x] ~~Vim~~
- [x] ~~Neovim~~
- [x] Emacs

Emacs and Vim are both magic editor. We can customize them what we
want. Furthermore using lisp to do that is happy. I really lvoe the editing
style with mode in vim and freely customizing in emacs, so I run emacs with
vim. By the way, they are native application without web technology, which I
never like to.

## Lang

All languages' developing dependencies and toolchains, such as compilers,
libraries and lsp, are installed by nix-shell and export into environment
per-project. Here list languages supporting in editor. The lsp client install
in user environment only when the language is used directly, i.e., tex and nix.

- **Haskell** :: main prog lang
- **Rust** :: main sys-prog lang
- **Common Lisp & Emacs Lisp** :: main script lang
- ~~Perl :: script lang~~
- ~~Julia :: main data-analysis lang~~
- orgmode & latex :: main doc lang
- ~~Agda :: For fun!~~
- ~~Coq :: proof only~~
- C/C++
- ~~R~~
- ~~Ruby~~
- ~~Python3:: only interperter by some utils~~
- ~~Web :: js, html, css/sass, ts~~

The other languages are also supposed in system and editor, but they aren't used
usally so they haven't a complete developing environment.

## Mirror

A mirror can help us to get resources quickly. But it is unstable. Only using
them when the network is bad. see tag for more.

# TODO

see: [todo.org](todo.org)

## Mail/Feed/Calendar/Password/Media/...

On Linux, I use emacs for mail(mu4e), rss(elfeed)
and other things. Gnus for mail is different from other tools such as
mu4e, you can check a description [here](https://www.gnu.org/software/emacs/manual/html_node/gnus/Mail-in-a-Newsreader.html#Mail-in-a-Newsreader) and [here](https://web.archive.org/web/20241108152000/https://www.rath.org/whats-wrong-with-gnus.html).
It is not fit for me, and the same reason for rss.
org-contacts can be used as contacts, and ebdb is
also good, but it saves data into database(elisp) instead of plain
text. Calender? Just org agenda. Furthermore, password-store is for password
management and rsync is for file syncing. Both of them are free and easy to
use, which is better than 1password and rclone with other servers. P2P for
personal using is enough.
Emacs can also manage medias with emms and play them with a backend, mpv is my
choice, which is extensible and simple.

I use org-mode to do GTD, diary and notes. And capturing web by pdf, which is
not easy like evernote, but I like it. Some website use eww with org for
capturing.
