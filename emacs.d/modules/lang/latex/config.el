;;; latex config -*- lexical-binding: t -*-
;;

(defconst +tex-keymaps '(LaTeX-mode-map tex-mode-map))

;; +nmap-lang-tex-def
(vonfry-def-nmap-lang-prefix tex nil
  :keymaps +tex-keymaps
  :prefix +nmap-lang-prefix)
