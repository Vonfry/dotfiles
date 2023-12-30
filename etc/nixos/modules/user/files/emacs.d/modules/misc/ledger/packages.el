;;; ledge/packages.el --- -*- lexical-binding: t -*-
;;

(use-package hledger-mode
  :mode "\\.journal$"
  :custom
  (ledger-binary-path "hledger")
  (hledger-jfile (getenv "LEDGER_FILE"))
  :config
  (evil-set-initial-state 'hledger-view-mode 'emacs)
  :general
  (nmap-at
    "l" 'hledger-jentry
    "L" 'hledger-run-command))
