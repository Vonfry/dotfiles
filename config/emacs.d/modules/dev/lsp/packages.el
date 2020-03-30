;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :after yasnippet projectile
  :hook ((prog-mode . lsp)
         (lsp-mode  . lsp-enable-which-key-integration))
  :custom
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  (lsp-diagnostic-package :flycheck)
  (lsp-keymap-prefix "M-*")
  :general
  (+mmap-lsp-def
    "."   'lsp-find-definition
    ","   'pop-tag-mark
    "="   'lsp-format-buffer
    "["   'lsp-find-declaration
    "{"   'lsp-find-references
    "#"   'lsp-organize-imports
    "}"   'lsp-goto-implementation
    "TAB" 'completion-at-point
    "("   'lsp-goto-type-definition)
  (+mmap-lsp-ext-def
    "r"   'lsp-execute-code-action
    "="   'lsp-format-region
    "r"   'lsp-restart-workspace
    "D"   'lsp-describe-session
    "h"   'lsp-symbol-highlight
    "L"   '(nil :which-key "lens")
    "L l" 'lsp-lens-show
    "L L" 'lsp-lens-hide
    "l"   'lsp-avy-lens))

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
            [remap xref-find-definitions] 'lsp-ui-peek-find-definitions
            [remap xref-find-references]  'lsp-ui-peek-find-references)
  (+mmap-lsp-ext-def
    ">"    '(nil :which-key "lsp-ui peek")
    "> ."  'lsp-ui-peek-find-definitions
    "> ;"  'lsp-ui-find-workspace-symbol
    "> {"  'lsp-ui-peek-find-references
    "> }"  'lsp-ui-peek-find-implementation
    "> n"  'lsp-ui-find-next-reference
    "> p"  'lsp-ui-find-prev-reference
    "> t"  'lsp-ui-peek--toggle-file
    "> q"  'lsp-ui-flycheck-list
    "> !"  'lsp-ui-peek--abort
    "> >"  'lsp-ui-peek--goto-xref
    "> <"  'lsp-ui-peek--goto-xref-other-window))

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
    "t" 'lsp-treemacs-symbols
    "Q" 'lsp-treemacs-errors-list)
  (+mmap-lsp-ext-def
    "{" 'lsp-treemacs-call-hierarchy
    "#" 'lsp-treemacs-deps-list)
  :config
  (lsp-metals-treeview-enable t)
  (lsp-treemacs-sync-mode t))
