;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :after yasnippet projectile
  :hook (prog-mode . lsp)
  :custom
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  (lsp-prefer-flymake nil)
  :general
  (+nmap-lsp-prefix-def
    ""    '(nil :which-key "lsp")
    "."   'lsp-goto-type-definition
    ","   'pop-tag-mark
    "r"   'lsp-execute-code-action
    "="   'lsp-format-buffer
    "h"   'lsp-symbol-highlight
    "["   'lsp-find-definition
    "}"   'lsp-find-references
    "#"   'lsp-organize-imports
    "{"   'lsp-goto-implementation
    "i"   'imenu
    "*"   'lsp-rename
    "R"   'lsp-restart-workspace
    "D"   'lsp-describe-session
    "TAB" 'completion-at-point)
  (+nmap-lsp-def
    "; l l" 'lsp-lens-show
    "; l L" 'lsp-lens-hide
    "; l a" 'lsp-avy-lens))

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
  (+nmap-lsp-def
    "; /" 'lsp-ui-find-workspace-symbol
    "; }" 'lsp-ui-peek-find-references
    "; ." 'lsp-ui-peek-find-definitions
    "; {" 'lsp-ui-peek-find-implementation)
  (+nmap-lsp-prefix-def
    "/"    'lsp-ui-find-workspace-symbol
    "n"    'lsp-ui-find-next-reference
    "p"    'lsp-ui-find-prev-reference
    "t"    'lsp-ui-peek--toggle-file
    "* n"  'lsp-ui-peek--select-next
    "* p"  'lsp-ui-peek--select-prev
    "* !"  'lsp-ui-peek--abort
    "* x"  'lsp-ui-peek--goto-xref
    "* o"  'lsp-ui-peek--goto-xref-other-window
    "* }"  'lsp-ui-peek-find-references
    "* ."  'lsp-ui-peek-find-definitions
    "* {"  'lsp-ui-peek-find-implementation))

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
  (+nmap-lsp-def
    "t"   'lsp-treemacs-symbols
    "q"   'lsp-treemacs-quick-fix
    "; t" 'lsp-treemacs-symbols
    "; q" 'lsp-treemacs-quick-fix
    "; d" 'lsp-treemacs-deps-list)
  :config
  (lsp-metals-treeview-enable t)
  (lsp-treemacs-sync-mode t))
