;;; ledge packages -*- lexical-binding: t -*-
;;

(package! hledger-mode
  :mode "\\.journal$"
  :custom
  (ledger-binary-path "hledger")
  (hledger-jfile (expand-file-name (format-time-string "%Y.journal")
                                   +hledger-path))
  :general
  (+mmap-at-def
    "l" 'hledger-jentry
    "L" 'hledger-run-command))
