;;; evil/packages.el --- -*- lexical-binding: t -*-
;;

(use-package evil-numbers
  :general
  ("C-c +" 'evil-numbers/inc-at-pt)
  ("C-c -" 'evil-numbers/dec-at-pt))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1))

(use-package evil-collection
  :custom
  (evil-collection-key-blacklist '("SPC" "S-SPC"))
  :config
  (evil-collection-init))
