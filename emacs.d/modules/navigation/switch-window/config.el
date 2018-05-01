;;; switch config -*- lexical-binding: t -*-

(use-package! switch-window
  :custom
  (switch-window-shortcut-style 'qwerty)
  (switch-window-aute-resize-window t)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-switch-window 'switch-window)
  ((kbd "C-x o") 'switch-window)
  ((kbd "C-x 1") 'switch-window-then-maximize)
  ((kbd "C-x 2") 'switch-window-then-split-below)
  ((kbd "C-x 3") 'switch-window-then-split-right)
  ((kbd "C-x 0") 'switch-window-then-delete))
