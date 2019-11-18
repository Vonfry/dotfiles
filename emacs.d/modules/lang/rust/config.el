;;; rust config -*- lexical-binding: t -*-
;;

(defconst +rust-keymaps 'rust-mode-map)

;; +nmap-lang-rust-def
(vonfry-def-nmap-lang-prefix rust nil
  :keymaps +rust-keymaps)

;; +nmap-rust-def
(vonfry-def-nmap-leader-prefix rust nil
  :keymaps +rust-keymaps)
