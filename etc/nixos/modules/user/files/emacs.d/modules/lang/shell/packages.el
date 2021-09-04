;; shell packages -*- lexical-binding: t -*-
;;

(use-package eshell
  :custom
  (eshell-cmpl-cycle-completions nil)
  (eshell-buffer-maximum-lines 20000)
  (eshell-history-size 350)
  (eshell-hist-ignoredups t)
  (eshell-buffer-shorthand t)
  (eshell-highlight-prompt nil)
  (eshell-plain-echo-behavior t)
  (eshell-directory-name (expand-file-name "eshell/" vonfry-cache-dir))
  :ensure nil)

(use-package terminal-here
  :custom
  (terminal-here-linux-terminal-command 'alacritty)
  :general
  (nmap-leader
    "$" 'terminal-here-launch
    "C-$" 'terminal-here-project-launch))

(nmap-leader "~" '+shell/open-file-manager-x)
