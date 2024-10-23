;;; tree-sitters/packages.el --- -*- lexical-binding: t -*-
;;

(use-package treesit
  :config
  (let ((remap-alist
         '((haskell-mode . haskell-ts-mode)
           (c-mode . c-ts-mode)
           (c++-mode . c++-ts-mode)
           (rust-mode . rust-ts-mode)
           (nix-mode . nix-ts-mode)
           ; (latex-mode . latex-ts-mode)
           ; (bibtex-mode . bibtex-ts-mode)
           ; (elisp-mode . elisp-ts-mode)
           ; (lisp-mode . lisp-ts-mode)
           ; (julia-mode . julia-ts-mode)
           (yaml-mode . yaml-ts-mode)
           (toml-mode . toml-ts-mode)
           (json-mode . json-ts-mode)
           (html-mode . html-ts-mode))))
    (mapc (lambda (alist)
            (add-to-list 'major-mode-remap-alist alist))
          remap-alist)))

