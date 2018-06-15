;;; flycheck packages -*- lexical-binding: t -*-
;;

(package! flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-leader
        +nmap-check 'flycheck-list-errors))

