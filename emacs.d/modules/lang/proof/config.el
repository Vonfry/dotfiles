;;; proof config -*- lexical-binding: t -*-
;;

(defconst +proof-kemaps 'coq-mode-map)

;; +nmap-lang-proof-def
(vonfry-def-nmap-lang-prefix proof nil
  :keymaps +proof-kemaps)
