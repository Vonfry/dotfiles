;;; haskell config -*- lexical-binding: t -*-
;;

(use-package haskell
  :ensure haskell-mode
  :hook (haskell-mode . eglot-ensure)
  :custom
  (haskell-indentation-layout-offset 4)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  (haskell-process-type 'auto)
  :general
  (nmap-leader :keymaps 'haskell-mode-map
    "="   'haskell-mode-stylish-buffer
    "r"   'haskell-compile
    "#"   'haskell-navigate-imports)
  (nmap-mode :keymaps 'haskell-mode-map
    "r"   'run-haskell
    "."   'haskell-mode-jump-to-def
    "h"   'hoogle
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

(use-package haskell-interactive-mode
  :ensure nil
  :general
  (nmap-leader :keymaps 'haskell-mode-map
    "\"" 'haskell-interactive-bring
    "k"  'haskell-interactive-mode-clear
    "m"  'haskell-menu
    "C"  'haskell-session-change-target))

(use-package haskell-process
  :ensure nil
  :general
  (nmap-mode :keymaps 'haskell-mode-map
    "p l" 'haskell-process-load-or-reload
    "p t" 'haskell-process-do-type
    "p i" 'haskell-process-do-info
    "p b" 'haskell-process-cabal-build
    "p c" 'haskell-process-cabal
    "p r" 'haskell-process-restart
    "R"   'haskell-debug)
  :custom
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t))
