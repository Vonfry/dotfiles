;;; latex config -*- lexical-binding: t -*-
;;

;; +mmap-mode-tex-def
(vonfry-def-mmap-mode-prefix tex nil
  :keymaps '(LaTeX-mode-map TeX-mode-map))

;; +mmap-tex-def
(vonfry-def-mmap-leader-prefix tex nil
  :keymaps '(LaTeX-mode-map TeX-mode-map))

(defcustom +tex-auto-private
  (expand-file-name "tex/" vonfry-cache-dir)
  "tex auto private file, see `tex-auto-private'"
  :group 'vonfry-modules
  :type 'directory)
