;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :after yasnippet projectile
  :hook (prog-mode . lsp)
  :custom
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  (lsp-prefer-flymake nil)
  :general
  (+mmap-lsp-prefix-def
    ""    '(nil :which-key "lsp")
    "i"   'imenu
    "*"   'lsp-rename
    "R"   'lsp-restart-workspace
    "D"   'lsp-describe-session
    "TAB" 'completion-at-point)
  (+mmap-lsp-def
    "."     'lsp-find-definition
    ","     'pop-tag-mark
    "r"     'lsp-execute-code-action
    "="     'lsp-format-buffer
    "}"     'lsp-find-references
    "#"     'lsp-organize-imports
    "{"     'lsp-goto-implementation
    ";"     '(nil :which-key "code")
    "; &"   'lsp-goto-type-definition
    "; h"   'lsp-symbol-highlight
    "; l"   '(nil :which-key "lens")
    "; l l" 'lsp-lens-show
    "; l L" 'lsp-lens-hide
    "; l a" 'lsp-avy-lens))

(package! lsp-clients
  :after lsp-mode
  :ensure nil)

(package! lsp-ui
  :after lsp-mode evil
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-flycheck-enable t)
  :general
  (:keymaps 'lsp-ui-mode-map
            [remap xref-find-definitions] #'lsp-ui-peek-find-definitions
            [remap xref-find-references]  #'lsp-ui-peek-find-references)
  (+mmap-lsp-def
    ">"   'lsp-ui-find-workspace-symbol
    "; }" 'lsp-ui-peek-find-references
    "; ." 'lsp-ui-peek-find-definitions
    "; {" 'lsp-ui-peek-find-implementation)
  (+mmap-lsp-prefix-def
    "n"    'lsp-ui-find-next-reference
    "p"    'lsp-ui-find-prev-reference
    "t"    'lsp-ui-peek--toggle-file
    "q"    'lsp-ui-flycheck-list
    "("    '(nil :which-key "lsp-ui peek")
    "( n"  'lsp-ui-peek--select-next
    "( p"  'lsp-ui-peek--select-prev
    "( !"  'lsp-ui-peek--abort
    "( x"  'lsp-ui-peek--goto-xref
    "( o"  'lsp-ui-peek--goto-xref-other-window
    "( }"  'lsp-ui-peek-find-references
    "( ."  'lsp-ui-peek-find-definitions
    "( {"  'lsp-ui-peek-find-implementation))

(package! lsp-ivy
  :after ivy lsp-mode
  :general
  (+mmap-lsp-def
    "["   'lsp-ivy-workspace-symbol
    "; [" 'lsp-ivy-global-workspace-symbol))

(package! company-lsp
  :after lsp-mode company yasnippet
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
  (+mmap-lsp-def
    "t"   'lsp-treemacs-symbols
    "q"   'lsp-treemacs-quick-fix
    "; t" 'lsp-treemacs-symbols
    "; d" 'lsp-treemacs-deps-list)
  :config
  (lsp-metals-treeview-enable t)
  (lsp-treemacs-sync-mode t))
