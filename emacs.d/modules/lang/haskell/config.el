;;; haskell config -*- lexical-binding: t -*-
;;

(defconst +haskell-keymaps 'haskell-mode-map)

;; +nmap-lang-haskell-def
(vonfry-def-nmap-lang-prefix haskell nil
  :keymaps +haskell-keymaps)

;; +nmap-haskell-def
(vonfry-def-nmap-leader-prefix haskell nil
  :keymaps +haskell-keymaps)
