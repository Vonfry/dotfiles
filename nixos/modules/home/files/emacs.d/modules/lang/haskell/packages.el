;;; haskell/config.el --- -*- lexical-binding: t -*-
;;

(use-package haskell-ts-mode
  :after eglot
  :hook
  ((haskell-ts-mode . eglot-ensure)
   (haskell-ts-mode .
    (lambda ()
      (setq-local compile-command "cabal build"))))
  :general
  (nmap-leader :keymaps 'haskell-ts-mode-map
    "\""  'haskell-ts-run-haskell
    "="   'haskell-ts-indent-defun)
  (vmap-leader :keymaps 'haskell-ts-mode-map
    "' RET" 'haskell-ts-compile-region-and-go)
  (nmap-mode :keymaps 'haskell-ts-mode-map
    "S"   'engine/search-hoogle))

(use-package consult-hoogle
  :general
  (nmap-mode :keymaps 'haskell-ts-mode-map
    "/" 'consult-hoogle
    "?" 'consult-hoogle-project
    "h" 'hoogle-buffer
    "H" 'hoogle-buffer-project
    "s" 'hoogle-buffer-web))
