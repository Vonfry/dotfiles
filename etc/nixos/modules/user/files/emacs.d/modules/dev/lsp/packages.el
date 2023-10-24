;;; lsp packages -*- lexical-binding: t -*-

(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)
  :general
  (nmap-leader :keymaps 'eglot-mode-map
    "="     'eglot-format-buffer
    "#"     'eglot-code-action-organize-imports
    "?"     'eldoc
    "> i"   'eglot-inlay-hints-mode
    "> r"   'eglot-rename
    "> a"   'eglot-code-actions
    "> W"   'eglot-code-action-rewrite
    "> q"   'eglot-code-action-quickfix
    "> i"   'eglot-code-action-inline
    "> e"   'eglot-code-action-extract
    "> R"   'eglot-reconnect
    "> s"   'eglot-shutdown
    "> S"   'eglot-shutdown-all
    "> D e" 'eglot-event-buffer
    "> D s" 'eglot-stderr-buffer
    "> D f" 'eglot-forget-pending-continuations
    "> D u" 'eglot-signal-didChangeConfiguration
    "> D c" 'eglot-clear-status)
  (vmap-leader :keymaps 'eglot-mode-map
    "=" 'eglot-format))

(use-package consult-eglot
  :after (eglot consult)
  :general
  (nmap-leader :keymaps 'eglot-mode-map
    "&" 'consult-eglot-symbols))
