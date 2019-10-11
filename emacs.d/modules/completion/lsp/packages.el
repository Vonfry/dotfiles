;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :hook (prog-mode . lsp)
  :custom
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-lsp-prefix
        "" '(nil :which-key "lsp")
        +nmap-go           'lsp-goto-type-definition
        +nmap-code         'lsp-lens-show
        +nmap-run          'lsp-execute-code-action
        +nmap-format       'lsp-format-buffer
        +nmap-highlight    'lsp-symbol-highlight
        +nmap-go-prompt    'lsp-find-definition
        ">"                'lsp-find-references
        +nmap-go-reference 'lsp-goto-implementation
        "i"                'imenu
        "*"                'lsp-rename
        "R"                'lsp-restart-workspace
        "D"                'lsp-describe-session
        "TAB"              'completion-at-point
        ))

(package! lsp-clients
  :after lsp-mode
  :ensure nil)

(package! lsp-ui
  :after lsp-mode evil
  :hook (lsp-mode . lsp-ui-mode)
  :general
  :general
  (:keymaps 'lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions
            [remap xref-find-references]  #'lsp-ui-peek-find-references)
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-lsp-prefix
        +nmap-swiper 'lsp-ui-find-workspace-symbol
        "fn" 'lsp-ui-find-next-reference
        "fp" 'lsp-ui-find-prev-reference
        "tf" 'lsp-ui-peek--toggle-file
        "sn" 'lsp-ui-peek--select-next
        "sp" 'lsp-ui-peek--select-prev
        "!"  'lsp-ui-peek--abort
        "{x" 'lsp-ui-peek--goto-xref
        "{o" 'lsp-ui-peek--goto-xref-other-window
        "{f" 'lsp-ui-peek-find-references
        "{d" 'lsp-ui-peek-find-definitions
        "{i" 'lsp-ui-peek-find-implementation
        "{s" 'lsp-ui-peek-find-workspace-symbol))

(package! company-lsp
  :after lsp-mode company
  :custom
  (company-lsp-async t)
  (company-lsp-cache-candidates t)
  (company-lsp-enable-snippet t)
  (company-lsp-enable-recompletion t)
  :config
  (push 'company-lsp company-backends))
