;;; switch config -*- lexical-binding: t -*-

(vonfry|use-package! switch-window
  :config
  (global-set-key (kbd "C-x o") 'switch-window)
  (global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
  (global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
  (global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
  (global-set-key (kbd "C-x 0") 'switch-window-then-delete)
  (custom-set-variables
   '(switch-window-shortcut-style 'qwerty)
   '(switch-window-aute-resize-window t))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-switch-window 'switch-window))
