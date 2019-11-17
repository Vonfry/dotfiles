;;; haskell config -*- lexical-binding: t -*-
;;

(package! haskell
  :straight haskell-mode
  :custom
  (haskell-indentation-layout-offset 2)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  (haskell-process-type 'auto)
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-leader
        +nmap-align     'haskell-mode-stylish-buffer
        +nmap-go-module 'haskell-navigate-imports)
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-haskell-compile-prefix
        "r" 'haskell-compile
        "c" 'run-haskell)
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        +nmap-go  'haskell-mode-jump-to-def
        +nmap-go-module 'haskell-navigate-imports
        "qh" 'hoogle
        "ql" 'haskell-hoogle-lookup-from-local
        "qe" 'engine/search-hoogle
        "qs" 'haskell-hoogle-start-server
        "qk" 'haskell-hoogle-start-server
        "t"  'haskell-mode-show-type-at
        "k"  'haskell-interactive-mode-clear
        "c"  'haskell-cabal-visit-file)
  :hook
  (haskell-mode .
    (lambda ()
      (haskell-auto-insert-module-template)
      (set (make-local-variable 'compile-command) "cabal build"))))

(package! haskell-interactive-mode
  :straight nil
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        +nmap-repl  'haskell-interactive-bring
        "k"  'haskell-interactive-mode-clear
        "sm" 'haskell-menu
        "sc" 'haskell-session-change-target))

(package! haskell-process
  :straight nil
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        "pl" 'haskell-process-load-or-reload
        "pt" 'haskell-process-do-type
        "pi" 'haskell-process-do-info
        "pb" 'haskell-process-cabal-build
        "pc" 'haskell-process-cabal
        "pr" 'haskell-process-restart)
  :custom
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t))

(package! lsp-haskell
  :after haskell lsp-mode)

(package! hasky-extensions
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        "y"  'hasky-extensions))
