;; shell/packages.el --- -*- lexical-binding: t -*-
;;

(use-package eshell
  :ensure nil
  :custom
  (eshell-cmpl-cycle-completions nil)
  (eshell-buffer-maximum-lines 20000)
  (eshell-history-size 350)
  (eshell-hist-ignoredups t)
  (eshell-buffer-shorthand t)
  (eshell-highlight-prompt nil)
  (eshell-plain-echo-behavior t)
  (eshell-directory-name (expand-file-name "eshell/" vonfry-local-dir))
  (eshell-prompt-function #'+eshell--prompt)
  (eshell-prompt-regexp +eshell--prompt-regexp)
  :general
  (imap :keymaps 'eshell-mode-map
    "C-d" 'consult-history
    "C-t" 'consult-fd)
  (nmap-leader "$" 'eshell)
  (nmap-mode :keymaps 'eshell-mode-map
    "r" 'consult-history
    "f" 'consult-fd))

(use-package em-alias
  ; load this manually to ensure `eshell/alias' existed.
  :after eshell
  :ensure nil
  :config
  (+eshell--init-aliases))

(use-package eshell-syntax-highlighting
  :after eshell
  :config
  (eshell-syntax-highlighting-global-mode 1))

(use-package eat
  :custom
  (eat-eshell-mode t)
  (eat-eshell-visual-command-mode t))
