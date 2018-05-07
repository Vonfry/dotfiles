;;; imenu config -*- lexical-binding: t -*-

(use-package! imenu-anywhere
  :config
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code 'counsel-imenu))

(use-package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-tag 'imenu-list-smart-toggle))
