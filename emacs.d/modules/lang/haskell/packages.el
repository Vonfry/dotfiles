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
  (+nmap-haskell-def
    "="   'haskell-mode-stylish-buffer
    "r"   'haskell-compile
    "R"   'haskell-debug
    "#"   'haskell-navigate-imports)
  (+nmap-lang-haskell-def
    "R"   'run-haskell
    "."   'haskell-mode-jump-to-def
    "h"   'hoogle
    "q"   '(nil :which-key "query")
    "q l" 'haskell-hoogle-lookup-from-local
    "q e" 'engine/search-hoogle
    "q s" 'haskell-hoogle-start-server
    "q k" 'haskell-hoogle-kill-server
    "t"   'haskell-mode-show-type-at
    "k"   'haskell-interactive-mode-clear
    "c"   'haskell-cabal-visit-file)
  :hook
  (haskell-mode .
    (lambda ()
      (haskell-auto-insert-module-template)
      (set (make-local-variable 'compile-command) "cabal build"))))

(package! haskell-interactive-mode
  :straight nil
  :general
  (+nmap-haskell-def
    "\"" 'haskell-interactive-bring
    "k"  'haskell-interactive-mode-clear
    "m"  'haskell-menu
    "C"  'haskell-session-change-target))

(package! haskell-process
  :straight nil
  :general
  (+nmap-lang-haskell-def
    "p"   '(nil :which-key "process")
    "p l" 'haskell-process-load-or-reload
    "p t" 'haskell-process-do-type
    "p i" 'haskell-process-do-info
    "p b" 'haskell-process-cabal-build
    "p c" 'haskell-process-cabal
    "p r" 'haskell-process-restart)
  :custom
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t))

(package! lsp-haskell
  :after haskell lsp-mode)

(package! hasky-extensions
  :general
  (+nmap-lang-haskell-def
    "{"  'hasky-extensions))
