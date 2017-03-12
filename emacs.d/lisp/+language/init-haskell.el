(require-package 'haskell-mode )
(require-package 'ghc)
(require-package 'company-ghc)
(require-package 'company-ghci)
(require-package 'company-cabal)
(require-package 'haskell-snippets)
(require-package 'intero)
(require-package 'hindent)
(defun vonfry/setup-haskell-mode ()
  (hindent-mode)
  (intero-mode)
  (with-eval-after-load 'yasnippet (haskell-snippets-initialize))
  (with-eval-after-load 'align
    (add-to-list 'align-rules-list
                 '(haskell-types
                   (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
                   (modes . haskell-modes)))
    (add-to-list 'align-rules-list
                 '(haskell-assignment
                   (regexp . "\\(\\s-+\\)=\\s-+")
                   (modes . haskell-modes)))
    (add-to-list 'align-rules-list
                 '(haskell-arrows
                   (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
                   (modes . haskell-modes)))
    (add-to-list 'align-rules-list
                 '(haskell-left-arrows
                   (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
                   (modes . haskell-modes))))
  (evil-leader/set-key-for-mode 'haskell-mode
    "f"  'hindent-reformat-decl
    "."  'intero-goto-definition
    "j"  'ghc-jump-file
    "D"  'intero-toggle-debug
    "A"  'intero-apply-suggestions
    "gi" 'haskell-navigate-imports
    "F"  'haskell-mode-stylish-buffer)
  (bind-key "C-c C-l" 'haskell-process-load-file haskell-mode-map)
  (with-eval-after-load 'company
    (push '(company-cabal)
      company-backends-haskell-cabal-mode))
  (setq tab-width 2)
  (setq evil-shift-width 2))
(add-hook 'haskell-mode-hook 'vonfry/setup-haskell-mode)

(provide 'init-haskell)
