;;; direnv packages -*- lexical-binding: t -*-
;;

(use-package envrc
  :general
  (nmap-leader :infix "'"
    "e"   'envrc-reload
    "E"   '(:ignore t :which-key "envrc")
    "E a" 'envrc-allow
    "E d" 'envrc-deny
    "E A" 'envrc-reload-all)
  :hook (after-init . envrc-global-mode))
