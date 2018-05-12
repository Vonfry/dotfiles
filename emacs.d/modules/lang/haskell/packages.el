;;; haskell config -*- lexical-binding: t -*-
;;

(package! haskell
  :ensure haskell-mode
  :custom
  (haskell-indentation-layout-offset 4)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  :hook
  ((haskell-mode . haskell-auto-insert-module-template)
  (haskell-mode .
    (lambda ()
      (custom-set-variables '(compile-command "stack build"))
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "qh" 'hoogle
            "ql" 'haskell-hoogle-lookup-from-local
            "qe" 'engine/search-hoogle
            "qs" 'haskell-hoogle-start-server
            "qk" 'haskell-hoogle-start-server
            "c"  'haskell-cabal-visit-file)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump-module 'haskell-navigate-imports
            vonfry-keybind-evil-run         'haskell-compile)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "y" 'hasky-extensions)))))


(package! intero
  :after haskell
  :hook
  (haskell-mode .
    (lambda ()
      (intero-mode t)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "?" 'intero-info
            "t" 'intero-type-at
            "g" 'intero-targets
            "i" 'intero-help-info
            "r" 'intero-help-refresh
            ";" 'intero-expand-splice-at-point
            "a" 'intero-add-package
            "d" 'intero-toggle-debug
            "l" 'intero-repl-load
            "e" 'intero-repl-eval-region
            "h" 'intero-highlight-uses-mode
            "n" 'intero-highlight-uses-mode-next
            "p" 'intero-highlight-uses-mode-prev
            "r" 'intero-highlight-uses-mode-replace
            "." 'intero-goto-definition
            ">" 'intero-uses-at)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-code-help 'intero-info))))

(package! hasky-extensions :after haskell-mode)
