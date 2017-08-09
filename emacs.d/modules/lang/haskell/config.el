;;; haskell config -*- lexical-binding: t -*-

(vonfry|use-package! haskell
  :config
  (custom-set-variables
    '(haskell-indentation-electric-flag t)
    '(compile-command "stack build"))
  (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
  (add-hook 'haskell-mode-hook 'flyspell-prog-mode)
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (add-hook 'haskell-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "c" 'haskell-cabal-visit-file)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump-module 'haskell-navigate-imports
            vonfry-keybind-evil-run         'haskell-compile))))

(vonfry|use-package! intero
  :after haskell
  :config
  (add-hook 'haskell-mode-hook
    (lambda ()
      (intero-mode)
      (intero-help-mode t)
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

(vonfry|use-package! ghc
  :after haskell
  :disabled
  :config
  (add-hook 'haskell-mode-hook 'ghc-init))

(vonfry|use-package! company-ghc
  :disabled
  :config
  (add-hook 'haskell-mode-hook
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-ghc)
      (custom-set-variables '(company-ghc-show-info t)))))

(vonfry|use-package! hindent
  :after haskell
  :config
  (add-hook 'haskell-mode-hook 'hindent-mode))

(vonfry|use-package! flycheck-haskell
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-haskell-setup))
