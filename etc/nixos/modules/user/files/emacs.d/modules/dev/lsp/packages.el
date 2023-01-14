;;; lsp packages -*- lexical-binding: t -*-

(use-package lsp-mode
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
    "> ."   'lsp-find-type-definition
    "> *"   'lsp-rename
    "> r"   'lsp-execute-code-action
    "> R"   'lsp-workspace-restart
    "> D"   'lsp-describe-session
    "> h"   'lsp-symbol-highlight
    "> ?"   'lsp-document-highlight
    "> L L" 'lsp-lens-mode
    "> L s" 'lsp-lens-show
    "> L h" 'lsp-lens-hide
    "> l"   'lsp-avy-lens)
  (vmap-leader :keymaps 'lsp-mode-map
    "=" 'lsp-format-region))

(use-package consult-lsp
  :after (lsp-mode consult)
  :general
  (nmap-leader :keymaps 'lsp-mode-map
    "&" 'consult-lsp-symbols
    "q" 'consult-lsp-diagnostics
    ":" 'consult-lsp-file-symbols))
