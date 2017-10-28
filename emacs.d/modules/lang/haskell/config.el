;;; haskell config -*- lexical-binding: t -*-

(use-package! haskell
  :config
  (custom-set-variables
    '(haskell-indentation-electric-flag t)
    '(imenu-add-menubar-index t)
    '(haskell-decl-scan-mode t))
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook
    (lambda ()
      (custom-set-variables '(compile-command "stack build"))
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "c" 'haskell-cabal-visit-file)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump-module 'haskell-navigate-imports
            vonfry-keybind-evil-run         'haskell-compile))))

(use-package! intero
  :after haskell
  :config
  (add-hook 'haskell-mode-hook
    (lambda ()
      (intero-mode t)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "i" 'intero-info
            "t" 'intero-type-at
            "g" 'intero-targets
            "h" 'intero-help-info
            "r" 'intero-help-refresh
            ";" 'intero-expand-splice-at-point
            "a" 'intero-add-package
            "d" 'intero-toggle-debug
            "l" 'intero-repl-load
            "e" 'intero-repl-eval-region
            "." 'intero-uses-at)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump-to-definition 'intero-goto-definition
            vonfry-keybind-evil-repl               'intero-repl))))

(use-package! ghc
  :after haskell
  :disabled
  :config
  (add-hook 'haskell-mode-hook 'ghc-init))

(use-package! company-ghc
  :disabled
  :config
  (add-hook 'haskell-mode-hook
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-ghc)
      (custom-set-variables '(company-ghc-show-info t)))))

(use-package! hindent
  :after haskell
  :config
  (add-hook 'haskell-mode-hook 'hindent-mode))
