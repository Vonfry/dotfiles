;;; flycheck config -*- lexical-binding: t -*-

(use-package! flycheck
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-check 'flycheck-list-errors))
