;;; haskell config -*- lexical-binding: t -*-
;;

(package! haskell
  :ensure haskell-mode
  :custom
  (haskell-indentation-layout-offset 2)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  (haskell-process-type 'auto)
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-leader
        +nmap-go-module 'haskell-navigate-imports)
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-haskell-compile-prefix
        "r" 'haskell-compile
        "c" 'run-haskell)
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        ""   '(nil :which-key "haskell")
        +nmap-go  'haskell-mode-jump-to-def
        +nmap-go-module 'haskell-navigate-imports
        "y"  'hasky-extensions
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
      (haskell-auto-insert-module-template t)
      (custom-set-variables '(compile-command "stack build")))))

(package! haskell-interactive-mode
  :ensure nil
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        ""   '(nil :which-key "haskell")
        +nmap-repl  'haskell-interactive-bring
        "k"  'haskell-interactive-mode-clear
        "sm" 'haskell-menu
        "sc" 'haskell-session-change-target))

(package! haskell-process
  :ensure nil
  :general
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-lang-prefix
        ""   '(nil :which-key "haskell")
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
