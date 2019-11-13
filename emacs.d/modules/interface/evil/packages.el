;;; evil packages -*- lexical-binding: t -*-
;;

(package! evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  (evil-set-initial-state 'dired-mode 'emacs)
  :custom
  (evil-shift-width 4)
  (evil-search-module 'evil-search)
  :general
  (nmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (nmap :prefix +nmap-leader
        +nmap-align     'align-regexp
        +nmap-terminal  'eshell
        +nmap-highlight 'evil-ex-nohighlight
        +nmap-repl      'comint-run)) ;; send to buff by using `append-to-buffer`

(package! evil-goggles
  :after evil
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(package! evil-numbers
  :after evil
  :general
  ("C-c +" 'evil-numbers/inc-at-pt)
  ("C-c -" 'evil-numbers/dec-at-pt))

(package! evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(package! evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode t))

(package! evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))
