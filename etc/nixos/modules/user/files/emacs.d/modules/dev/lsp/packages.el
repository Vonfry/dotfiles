;;; lsp packages -*- lexical-binding: t -*-

(use-package lsp-mode
  :after (yasnippet projectile)
  :hook (lsp-mode . lsp-enable-which-key-integration)
  :custom
  (lsp-enable-suggest-server-download nil)
  (lsp-completion-provider :none)
  (lsp-server-install-dir (expand-file-name "lsp" vonfry-cache-dir))
  (lsp-session-file (expand-file-name "lsp-session" vonfry-local-dir))
  (lsp-keymap-prefix "M-*")
  :general
  (nmap-leader :keymaps 'lsp-mode-map
    "."     'lsp-find-definition
    "["     'lsp-find-declaration
    ","     'pop-tag-mark
    "="     'lsp-format-buffer
    "#"     'lsp-organize-imports
    "{"     'lsp-find-references
    "}"     'lsp-find-implementation
    "TAB"   'completion-at-point
    "("     'lsp-goto-type-definition
    "?"     'lsp-describe-thing-at-point
    ">"     '(:ignore t :which-key "lsp ext")
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

(use-package lsp-ivy
  :after lsp-mode
  :general
  (nmap-leader :keymaps 'lsp-mode-map
    "&" 'lsp-ivy-workspace-symbol
    "> &" 'lsp-ivy-global-workspace-symbol))
