;;; debugger packages -*- lexical-binding: t -*-
;;

(package! realgud
  :hook
  (realgud-short-key-mode .
    (lambda ()
      (local-set-key "\C-c" realgud:shortkey-mode-map)))
  :general
  (nmap-leader
    :keymaps 'realgud-short-key-mode-map
    "'" 'realgud:shortkey-mode-map))

