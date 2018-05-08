;;; smart-jump config -*- lexical-binding: t -*-

(use-package! smart-jump
  :after dumb-jump
  :config
  (smart-jump-register :modes 'elpy-mode) ; use xref
  (smart-jump-register :modes 'ess-mode) ; use xref
  (smart-jump-register :modes   'lispy-mode
                       :jump-fn 'lispy-goto-symbol
                       :pop-fn  'pop-tag-mark
                       :refs-fn 'smart-jump-simple-find-references)
  (start-jump-setup-default-registers)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-jump-symbol    'smart-jump-go
        vonfry-keybind-evil-jump-back      'smart-jump-back
        vonfry-keybind-evil-jump-peek      'smart-jump-peek
        vonfry-keybind-evil-jump-reference 'smart-jump-references))

