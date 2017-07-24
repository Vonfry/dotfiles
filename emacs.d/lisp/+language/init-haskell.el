(require-package 'haskell-mode)
(require-package 'hare)
(require-package 'ghc)
(require-package 'company-ghc)
(require-package 'company-cabal)
(require-package 'haskell-snippets)
(require-package 'flycheck-haskell)
(require-package 'hindent)
(require-package 'intero)
(defun vonfry/setup-haskell-mode ()
  (require 'ghc)
  (require 'haskell-snippets)
  ; (yas-recompile-all)
  ; (yas-reload-all)
  (ghc-init)
  (hare-init)
  (hindent-mode)
  (haskell-auto-insert-module-template)
  ; Only use this if the project using with stack.
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
    "q"  'ghc-display-errors
    "f"  'hindent-reformat-decl
    "'"  'intero-repl
    "."  'intero-goto-definition
    "j"  'ghc-jump-file
    "D"  'intero-toggle-debug
    "A"  'intero-apply-suggestions
    "gi" 'haskell-navigate-imports
    "F"  'haskell-mode-stylish-buffer)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-ghc))
  (ghc-comp-init)
  (eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
  (intero-mode)
  (setq tab-width 4
        evil-shift-width 4
        hindent-line-length 120
        hindent-indent-size 4)
  (custom-set-variables
    '(haskell-indentation-electric-flag t)))
(add-hook 'haskell-mode-hook 'vonfry/setup-haskell-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (add-to-list 'exec-path my-cabal-path))

(provide 'init-haskell)
