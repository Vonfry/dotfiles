;;; imenu config -*- lexical-binding: t -*-

(use-package! imenu-anywhere
  :config
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code 'helm-imenu-anywhere))

(use-package! imenu-list
  :config
  (custom-set-variables
   '(imenu-list-focus-after-activation t)
   '(imenu-list-auto-resize t))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-tag 'imenu-list-smart-toggle))
