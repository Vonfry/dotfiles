;;; haskell config -*- lexical-binding: t -*-
;;

(use-package haskell
  :ensure haskell-mode
  :hook
  ((haskell-mode . eglot-ensure)
   (haskell-mode .
    (lambda ()
      (haskell-auto-insert-module-template)
      (set (make-local-variable 'compile-command) "cabal build"))))
  :custom
  (haskell-indentation-layout-offset 4)
  (imenu-add-menubar-index t)
  (haskell-decl-scan-mode t)
  (haskell-process-type 'auto)
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t)
  :general
  (nmap-leader :keymaps 'haskell-mode-map
    "="   'haskell-mode-stylish-buffer
    "r"   'haskell-compile
    "#"   'haskell-navigate-imports
    "\""  'haskell-interactive-bring
    "R"   'haskell-debug)
  (nmap-mode :keymaps 'haskell-mode-map
    "r"   'run-haskell
    "."   'haskell-mode-jump-to-def
    "h"   'hoogle
    "q l" 'haskell-hoogle-lookup-from-local
    "q e" 'engine/search-hoogle
    "q s" 'haskell-hoogle-start-server
    "q k" 'haskell-hoogle-kill-server
    "t"   'haskell-mode-show-type-at
    "c"   'haskell-cabal-visit-file
    "p l" 'haskell-process-load-or-reload
    "p t" 'haskell-process-do-type
    "p i" 'haskell-process-do-info
    "p b" 'haskell-process-cabal-build
    "p c" 'haskell-process-cabal
    "p r" 'haskell-process-restart
    "k"   'haskell-interactive-mode-clear
    "m"   'haskell-menu
    "C"   'haskell-session-change-target)
  (nmap-leader :keymaps 'haskell-interactive-mode-map
    "k"   'haskell-interactive-mode-clear))
