;;; lsp packages -*- lexical-binding: t -*-

(use-package lsp-mode
  :after (yasnippet projectile)
  :hook lsp-enable-which-key-integration
  :custom
  (lsp-server-install-dir (expand-file-name "lsp" vonfry-cache-dir))
  (lsp-session-file (expand-file-name "lsp-session" vonfry-cache-dir))
  (lsp-diagnostic-package :flycheck)
  (lsp-keymap-prefix "M-*")
  :general
  (nmap-leader :keymaps 'lsp-mode-map
    "."     'lsp-find-definition
    "["     'lsp-find-declaration
    ","     'pop-tag-mark
    "="     'lsp-format-buffer
    "#"     'lsp-organize-imports
    "TAB"   'completion-at-point
    "("     'lsp-goto-type-definition
    "?"     'lsp-describe-thing-at-point
    ">"     '(:ignore t :which-key "lsp ext")
    "> {"   'lsp-find-references
    "> }"   'lsp-find-implementation
    "> ."   'lsp-find-type-definition
    "> *"   'lsp-rename
    "> r"   'lsp-execute-code-action
    "> R"   'lsp-restart-workspace
    "> D"   'lsp-describe-session
    "> h"   'lsp-symbol-highlight
    "> ?"   'lsp-document-highlight
    "> L"   '(:ignore t :which-key "lens")
    "> L L" 'lsp-lens-mode
    "> L s" 'lsp-lens-show
    "> L h" 'lsp-lens-hide
    "> l"   'lsp-avy-lens)
  (vmap-leader :keymaps 'lsp-mode-map
    "="   'lsp-format-region
    "> =" 'align-regexp))

(use-package lsp-treemacs
  :after (treemacs lsp-mode)
  :general
  (nmap-leader :keymaps 'lsp-mode-map
    "{"   'lsp-treemacs-references
    "}"   'lsp-treemacs-implementations
    "t"   'lsp-treemacs-symbols
    "q"   'lsp-treemacs-errors-list
    "> [" 'lsp-treemacs-call-hierarchy
    "> #" 'lsp-treemacs-deps-list)
  :config
  (lsp-treemacs-sync-mode t))

(use-package lsp-ivy
  :after lsp-mode
  :general
  (nmap-leader :keymaps 'lsp-mode-map
    "&" 'lsp-ivy-workspace-symbol
    "> &" 'lsp-ivy-global-workspace-symbol))
