;;; haskell config -*- lexical-binding: t -*-
;;

(package! haskell
  :ensure haskell-mode
  :custom
  (haskell-indentation-layout-offset 4)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-jump-module 'haskell-navigate-imports
        vonfry-keybind-evil-run         'haskell-compile)
  (nmap :keymaps 'haskell-mode-map
        :prefix +lang-nmap-prefix
        "y" 'hasky-extensions
        "qh" 'hoogle
        "ql" 'haskell-hoogle-lookup-from-local
        "qe" 'engine/search-hoogle
        "qs" 'haskell-hoogle-start-server
        "qk" 'haskell-hoogle-start-server
        "c"  'haskell-cabal-visit-file)
  :hook
  ((haskell-mode . haskell-auto-insert-module-template)
  (haskell-mode .
    (lambda ()
      (custom-set-variables '(compile-command "stack build"))))))


(package! intero
  :after haskell
  :general
  (nmap :keymaps 'intero-mode-map
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
  (nmap :keymaps 'intero-mode-map
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code-help 'intero-info)
  :hook (haskell-mode .  intero-mode))

(package! hasky-extensions :after haskell-mode)
