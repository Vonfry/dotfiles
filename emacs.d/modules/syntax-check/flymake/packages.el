;;; flycheck packages -*- lexical-binding: t -*-
;;

(package! flymake
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-leader
        +nmap-check 'flymake-show-diagnostics-buffer))

