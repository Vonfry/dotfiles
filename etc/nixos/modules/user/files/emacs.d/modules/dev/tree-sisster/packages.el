;;; tree-sitters packages -*- lexical-binding: t -*-
;;

(use-package treesit
  :custom
  (major-mode-remap-alist
   '(; (haskell-mode . haskell-ts-mode)
     (c-mode . c-ts-mode)
     (c++-mode . c++-ts-mode)
     (rust-mode . rust-ts-mode)
     ; (nix-mode . nix-ts-mode)
     ; (latex-mode . latex-ts-mode)
     ; (bibtex-mode . bibtex-ts-mode)
     ; (elisp-mode . elisp-ts-mode)
     ; (lisp-mode . lisp-ts-mode)
     ; (julia-mode . julia-ts-mode)
     ; (perl-mode . perl-ts-mode)
     ; (cperl-mode . cperl-ts-mode)
     (yaml-mode . yaml-ts-mode)
     (toml-mode . toml-ts-mode)
     (json-mode . json-ts-mode)
     (html-mode . html-ts-mode))))
