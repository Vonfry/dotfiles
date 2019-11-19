;;; latex config -*- lexical-binding: t -*-
;;

;; +mmap-lang-tex-def
(vonfry-def-mmap-lang-prefix tex nil
  :keymaps '(LaTeX-mode-map TeX-mode-map))

;; +mmap-tex-def
(vonfry-def-mmap-leader-prefix tex nil
  :keymaps '(LaTeX-mode-map TeX-mode-map))
