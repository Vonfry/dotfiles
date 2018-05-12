;;; evil packages -*- lexical-binding: t -*-
;;

(package! evil
  :config
  (evil-mode 1)
  :custom
  (evil-shift-width 4)
  :general
  (nmap "gB" 'previous-buffer
        "gb" 'next-buffer)
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-terminal      'eshell
        vonfry-keybind-evil-marks         'evil-show-marks)
  (nmap :prefix +evil-window-nmap-prefix
        "v" 'split-window-vertically
        "h" 'split-window-horizontally
        "b" 'split-window-below
        "r" 'split-window-right
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

(package! evil-lion
  :after evil
  :config
  (evil-lion-mode t))
