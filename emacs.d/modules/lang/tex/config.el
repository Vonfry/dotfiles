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

(defcustom +tex-region
  (expand-file-name "_region_" +tex-auto-private)
  "tex region ile, see `TeX-region'"
  :group 'vonfry-modules
  :type 'directory)
