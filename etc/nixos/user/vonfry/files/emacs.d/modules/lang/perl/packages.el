;;; perl packages -*- lexical-binding: t -*-
;;

(package! cperl-mode
  :ensure nil
  :hook lsp
  :general
  (+mmap-mode-perl-def
    "l" 'cperl-lineup
    "d" 'cperl-perldoc
    "?" 'cperl-perldoc-at-point
    "=" 'cperl-indent-line)
  :init
  (alias! 'perl-mode 'cperl-mode))
