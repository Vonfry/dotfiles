;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :after yasnippet
  :hook (prog-mode . lsp)
  :custom
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  :general
  (nmap :keymaps 'lsp-mode-map
        :prefix +nmap-lsp-prefix
        "" '(nil :which-key "lsp")
        +nmap-go                'lsp-goto-type-definition
        +nmap-go-back           'pop-tag-mark
        +nmap-run               'lsp-execute-code-action
        +nmap-format            'lsp-format-buffer
        +nmap-highlight         'lsp-symbol-highlight
        +nmap-go-prompt         'lsp-find-definition
        +nmap-go-reference      'lsp-find-references
        +nmap-go-module         'lsp-organize-imports
        +nmap-go-implementation 'lsp-goto-implementation
        "i"                     'imenu
        "*"                     'lsp-rename
        "R"                     'lsp-restart-workspace
        "D"                     'lsp-describe-session
        "TAB"                   'completion-at-point)
  (nmap :keymaps 'lsp-mode-map
        :prefix +nmap-code-prefix
        +nmap-go                'lsp-goto-type-definition
        +nmap-run               'lsp-execute-code-action
        +nmap-format            'lsp-format-buffer
        +nmap-highlight         'lsp-symbol-highlight
        +nmap-go-prompt         'lsp-find-definition
        +nmap-go-reference      'lsp-find-references
        +nmap-go-module         'lsp-organize-imports
        +nmap-go-implementation 'lsp-goto-implementation
        "ll" 'lsp-lens-show
        "lL" 'lsp-lens-hide
        "la" 'lsp-avy-lens))

(package! lsp-clients
  :after lsp-mode
  :straight nil)

(package! lsp-ui
  :after lsp-mode evil
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-flycheck-enable t)
  :general
  (:keymaps 'lsp-ui-mode-map
            [remap xref-find-definitions] #'lsp-ui-peek-find-definitions
            [remap xref-find-references]  #'lsp-ui-peek-find-references)
  (nmap :keymaps 'lsp-mode-map
        :prefix +nmap-code-prefix
        +nmap-swiper            'lsp-ui-find-workspace-symbol
        +nmap-go-reference      'lsp-ui-peek-find-references
        +nmap-go                'lsp-ui-peek-find-definitions
        +nmap-go-implementation 'lsp-ui-peek-find-implementation
        )
  (nmap :keymaps 'lsp-mode-map
        :prefix +nmap-lsp-prefix
        +nmap-swiper  'lsp-ui-find-workspace-symbol
        "n"           'lsp-ui-find-next-reference
        "p"           'lsp-ui-find-prev-reference
        "t"           'lsp-ui-peek--toggle-file
        "pn"          'lsp-ui-peek--select-next
        "pp"          'lsp-ui-peek--select-prev
        "p!"          'lsp-ui-peek--abort
        "px"          'lsp-ui-peek--goto-xref
        "po"          'lsp-ui-peek--goto-xref-other-window
        "p}"          'lsp-ui-peek-find-references
        "p."          'lsp-ui-peek-find-definitions
        "p{"          'lsp-ui-peek-find-implementation))

(package! company-lsp
  :after lsp-mode company
  :custom
  (company-lsp-async t)
  (company-lsp-cache-candidates t)
  (company-lsp-enable-snippet t)
  (company-lsp-enable-recompletion t)
  :config
  (push 'company-lsp company-backends))

(package! lsp-treemacs
  :after treemacs lsp-mode
  :general
  (nmap :keymaps 'lsp-mode-map
        :prefix +nmap-leader
        +nmap-tag   'lsp-treemacs-symbols
        +nmap-check 'lsp-treemacs-quick-fix)
  (nmap :keymaps 'lsp-mode-map
        :prefix +nmap-code-prefix
        "t" 'lsp-treemacs-symbols
        "q" 'lsp-treemacs-quick-fix
        "d" 'lsp-treemacs-deps-list)
  :config
  (lsp-metals-treeview-enable t)
  (lsp-treemacs-sync-mode t))
