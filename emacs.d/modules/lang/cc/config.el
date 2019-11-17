;;; cc config -*- lexical-binding: t -*-
;;

(defconst +cc-keymaps '(c-mode-map c++-mode-map objc-mode-map))
;; +nmap-lang-cc-def
(vonfry-nmap-def-lang-prefix cc nil
  :keymaps +cc-keymaps)
