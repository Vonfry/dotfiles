;;; nix config -*- lexical-binding: t -*-
;;

(package! nix-mode
  :interpreter ("nix-shell" . nix-shebang-mode)
  :hook lsp
  :general
  (+mmap-nix-def
    "="  'nix-format-buffer
    "\"" 'nix-repl
    "r"  'nix-build)
  (+mmap-mode-nix-def
    "u"  'nix-unpack
    "/"  'nix-search
    "="  'nix-indent-line))
