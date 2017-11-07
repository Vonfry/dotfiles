;;; browse config -*- lexical-binding: t -*-

(use-package! ecb
  :init
  (custom-set-variables
   '(ecb-auto-expand-directory-tree "best")
   '(ecb-auto-update-methods-after-save t)))

(use-package! speedbar)

(use-package! sr-speedbar
  :after speedbar
  :config
  (custom-set-variables
   '(sr-speedbar-auto-refresh t)))

(use-package! projectile-speedbar
  :after sr-speedbar
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-speedbar 'sr-speedbar-toggle))
