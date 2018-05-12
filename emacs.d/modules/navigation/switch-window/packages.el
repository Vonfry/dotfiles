;;; switch packages -*- lexical-binding: t -*-
;;

(package! switch-window
  :custom
  (switch-window-shortcut-style 'qwerty)
  (switch-window-aute-resize-window t)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-switch-window 'switch-window)
  ("C-x o" 'switch-window)
  ("C-x 1" 'switch-window-then-maximize)
  ("C-x 2" 'switch-window-then-split-below)
  ("C-x 3" 'switch-window-then-split-right)
  ("C-x 0" 'switch-window-then-delete))
