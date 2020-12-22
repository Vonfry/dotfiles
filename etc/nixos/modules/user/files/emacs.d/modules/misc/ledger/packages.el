;;; ledge packages -*- lexical-binding: t -*-
;;

(package! hledger-mode
  :mode "\\.journal$"
  :custom
  (ledger-binary-path "hledger")
  (hledger-jfile (expand-file-name (format-time-string "%Y.journal")
                                   +hledger-path))
  :hook
  (evil-mode . (lambda ()
    (evil-set-initial-state 'hledger-view-mode 'emacs)))
  :general
  (nmap-at
    "l" 'hledger-jentry
    "L" 'hledger-run-command))
