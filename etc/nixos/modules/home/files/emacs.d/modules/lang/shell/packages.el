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
  :config
  (+eshell--init-aliases)
  :general
  (nmap-leader "$" 'eshell))

(use-package eshell-syntax-highlighting
  :after eshell
  :config
  (eshell-syntax-highlighting-global-mode 1))

(use-package esh-autosuggest
  :after eshell
  :hook (eshell-mode))
