;;; proof config -*- lexical-binding: t -*-
;;

(use-package proof-general
  :general
  (nmap-leader :keymaps 'coq-mode-map
    "\""     'proof-shell-start
    "' x"    'proof-shell-exit
    "' >"    'proof-autosend-toggle
    "' u"    'proof-undo-last-successful-command
    "DEL"    'proof-undo-and-delete-last-successful-command
    "RET"    'proof-goto-point)
  (nmap-mode :keymaps 'coq-mode-map
    "b"      'proof-process-buffer
    "r"      'proof-retract-buffer
    "p"      'proof-prf
    "t"      'proof-ctxt
    "h"      'proof-help
    "`"      'proof-next-error
    "f"      'proof-find-theorems
    "v"      'proof-minibuffer-cmd
    "b"      'proof-toolbar-toggle
    "c"      'proof-interrupt-process
    "d"      'proof-tree-external-display-toggle
    "s"      'proof-toggle-active-scripting
    "o"      'proof-display-some-buffers
    "w"      'pg-response-clear-displays
    "l"      'proof-layout-windows
    "n"      'proof-assert-next-command-interactive))

(use-package company-coq
  :after company
  :hook
  (coq-mode . company-coq-mode)
  :general
  (nmap-mode :keymaps 'coq-mode-map
    "B" 'company-coq-cite))
