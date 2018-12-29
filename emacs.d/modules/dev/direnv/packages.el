;;; direnv packages -*- lexical-binding: t -*-
;;

(use-package direnv
  :custom
  (direnv-non-file-modes
    '(ielm-mode
      eshell-mode
      haskell-interactive-mode
      inf-ruby-mode
      geiser-mode
      slime-mode))
  :config
  (direnv-mode))
