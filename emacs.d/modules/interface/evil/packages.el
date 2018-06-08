;;; evil packages -*- lexical-binding: t -*-
;;

(package! evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  :custom
  (evil-shift-width 4)
  :general
  (nmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (nmap :prefix +nmap-leader
        +nmap-align    'align-regexp
        +nmap-terminal 'eshell)
  (nmap :prefix +nmap-window-prefix
        "v" 'split-window-vertically
        "h" 'split-window-horizontally
        "j" 'split-window-below
        "l" 'split-window-right
        "w" 'delete-window
        "k" 'kill-current-buffer
        "c" 'delete-frame
        "t" 'toggle-window-split
        "o" 'delete-other-windows))

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

(package! evil-snipe
  :after evil
  :config
  (evil-snipe-mode 1)
  (evil-snipe-override-mode 1))

(package! evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))
