;;; haskell/config.el --- -*- lexical-binding: t -*-
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
    "R"   'haskell-debug
    "' k" 'haskell-interactive-mode-clear
    "' p" 'haskell-process-cd
    "' l" 'haskell-process-load-file
    "' t" 'haskell-process-do-type
    "' i" 'haskell-process-do-info
    "' b" 'haskell-process-cabal-build
    "' c" 'haskell-process-cabal
    "' r" 'haskell-process-restart)
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
    "m"   'haskell-menu
    "C"   'haskell-session-change-target)
  (nmap-leader :keymaps 'haskell-interactive-mode-map
    "k"   'haskell-interactive-mode-clear))
