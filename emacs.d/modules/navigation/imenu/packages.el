;;; imenu packages -*- lexical-binding: t -*-

(package! imenu-anywhere
  :config
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code 'ivy-imenu-anywhere))

(package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-tag 'imenu-list-smart-toggle))
