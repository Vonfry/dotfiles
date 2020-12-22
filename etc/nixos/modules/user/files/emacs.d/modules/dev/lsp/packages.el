;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :after (yasnippet projectile)
  :hook lsp-enable-which-key-integration
  :custom
  (lsp-server-install-dir (expand-file-name "lsp" vonfry-cache-dir))
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  (lsp-diagnostic-package :flycheck)
  (lsp-keymap-prefix "M-*")
  :general
  (+mmap-lsp-def
    "."   'lsp-find-definition
    "["   'lsp-find-declaration
    ","   'pop-tag-mark
    "="   'lsp-format-buffer
    "#"   'lsp-organize-imports
    "TAB" 'completion-at-point
    [tab] 'completion-at-point
    "("   'lsp-goto-type-definition
    "?"   'lsp-describe-thing-at-point)
  (+mmap-lsp-ext-def
    "{"   'lsp-find-references
    "}"   'lsp-find-implementation
    "."   'lsp-find-type-definition
    "*"   'lsp-rename
    "r"   'lsp-execute-code-action
    "="   'lsp-format-region
    "R"   'lsp-restart-workspace
    "D"   'lsp-describe-session
    "h"   'lsp-symbol-highlight
    "?"   'lsp-document-highlight
    "L"   '(nil :which-key "lens")
    "L L" 'lsp-lens-mode
    "L s" 'lsp-lens-show
    "L h" 'lsp-lens-hide
    "l"   'lsp-avy-lens))

(package! lsp-treemacs
  :after (treemacs lsp-mode)
  :general
  (+mmap-lsp-def
    "{" 'lsp-treemacs-references
    "}" 'lsp-treemacs-implementations
    "t" 'lsp-treemacs-symbols
    "q" 'lsp-treemacs-errors-list)
  (+mmap-lsp-ext-def
    "[" 'lsp-treemacs-call-hierarchy
    "#" 'lsp-treemacs-deps-list)
  :config
  (lsp-treemacs-sync-mode t))


(package! lsp-ivy
  :after lsp-mode
  :general
  (+mmap-lsp-def
    "&" 'lsp-ivy-workspace-symbol)
  (+mmap-lsp-ext-def
    "&" 'lsp-ivy-global-workspace-symbol))
