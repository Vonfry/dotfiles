;;; smart-jump packages -*- lexical-binding: t -*-
;;

(package! smart-jump
  :after dumb-jump
  :config
  (smart-jump-register :modes 'elpy-mode) ; use xref
  (smart-jump-register :modes 'ess-mode) ; use xref
  (smart-jump-setup-default-registers)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-jump-symbol    'smart-jump-go
        vonfry-keybind-evil-jump-back      'smart-jump-back
        vonfry-keybind-evil-jump-peek      'smart-jump-peek
        vonfry-keybind-evil-jump-reference 'smart-jump-references))

