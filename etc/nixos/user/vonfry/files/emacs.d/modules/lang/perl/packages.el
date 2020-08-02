;;; perl packages -*- lexical-binding: t -*-
;;

(package! cperl-mode
  :ensure nil
  :hook lsp
  :general
  (+mmap-mode-perl-def
   "l" 'cperl-lineup)
  :init
  (alias! 'perl-mode 'cperl-mode))
