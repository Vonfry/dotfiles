;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-lang-action
        "" '(nil :which-key "lsp")
        +nmap-run       'lsp-execute-code-action
        +nmap-format    'lsp-format-buffer
        +nmap-highlight 'lsp-symbol-highlight
        "i"  'lsp-info-under-point
        "dt" 'lsp-goto-type-definition
        "*"  'lsp-rename
        "R"  'lsp-restart-workspace
        "gI" 'lsp-goto-implementation))

(package! lsp-imenu
  :ensure nil
  :hook (lsp-after-open . lsp-enable-imenu))

(package! lsp-ui
  :after lsp-mode evil
  :hook (lsp-mode . lsp-ui-mode)
  :general
  :general
  (:keymaps 'lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions
            [remap xref-find-references]  #'lsp-ui-peek-find-references)
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-lsp-prefix
        +nmap-code 'lsp-ui-find-workspace-symbol
        "fn" 'lsp-ui-find-next-reference
        "fp" 'lsp-ui-find-prev-reference
        "tf" 'lsp-ui-peek--toggle-file
        "sn" 'lsp-ui-peek--select-next
        "sp" 'lsp-ui-peek--select-prev
        "gx" 'lsp-ui-peek--goto-xref
        "go" 'lsp-ui-peek--goto-xref-other-window
        "!"  'lsp-ui-peek--abort
        "gf" 'lsp-ui-peek-find-references
        "gd" 'lsp-ui-peek-find-definitions
        "gi" 'lsp-ui-peek-find-implementation
        "gs" 'lsp-ui-peek-find-workspace-symbol))

(package! company-lsp
  :after lsp-mode company
  :custom
  (company-lsp-async t)
  (company-lsp-cache-candidates t)
  (company-lsp-enable-snippet t)
  (company-lsp-enable-recompletion t)
  :config
  (push 'company-lsp company-backends))
