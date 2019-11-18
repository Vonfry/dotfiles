;;; proof config -*- lexical-binding: t -*-
;;

(package! proof-general
  :general
  (+nmap-lang-proof-def
    "RET"    'proof-goto-point
    "b"      'proof-process-buffer
    "r"      'proof-retract-buffer
    "$"      'proof-shell-start
    "x"      'proof-shell-exit
    "p"      'proof-prf
    "t"      'proof-ctxt
    "h"      'proof-help
    "`"      'proof-next-error
    "f"      'proof-find-theorems
    "v"      'proof-minibuffer-cmd
    "b"      'proof-toolbar-toggle
    ">"      'proof-autosend-toggle
    "c"      'proof-interrupt-process
    "d"      'proof-tree-external-display-toggle
    "s"      'proof-toggle-active-scripting
    "DEL"    'proof-undo-and-delete-last-successful-command
    "o"      'proof-display-some-buffers
    "w"      'pg-response-clear-displays
    "l"      'proof-layout-windows
    "u"      'proof-undo-last-successful-command
    "n"      'proof-assert-next-command-interactive))

(package! company-coq
  :after proof-general company
  :hook (coq-mode . company-coq-mode)
  :general
  (+nmap-lang-proof-def
    "B" 'company-coq-cite))
