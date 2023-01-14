;;; lsp packages -*- lexical-binding: t -*-

(use-package eglot
  :ensure nil
  :custom
  (lsp-enable-suggest-server-download nil)
  (lsp-completion-provider :none)
  (lsp-server-install-dir (expand-file-name "lsp" vonfry-cache-dir))
  (lsp-session-file (expand-file-name "lsp-session" vonfry-local-dir))
  (lsp-keymap-prefix "M-*")
  :general
  (nmap-leader :keymaps 'eglot-mode-map
    "="     'eglot-format-buffer
    "#"     'eglot-code-action-organize-imports
    "> r"   'eglot-rename
    "> a"   'eglot-execute-code-actions
    "> W"   'eglot-execute-code-action-rewrite
    "> q"   'eglot-code-action-quickfix
    "> i"   'eglot-execute-code-action-inline
    "> e"   'eglot-execute-code-action-extract
    "> r"   'eglot-reconnect
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
