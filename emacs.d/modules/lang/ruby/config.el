;;; ruby config -*- lexical-binding: t -*-
;;

(defconst +ruby-keymaps 'enh-ruby-mode-map)

;; +nmap-lang-ruby-def
(vonfry-def-nmap-lang-prefix ruby nil
  :keymaps +ruby-keymaps)

;; +vmap-lang-ruby-def
(vonfry-def-vmap-lang-prefix ruby nil)
  :keymaps +ruby-keymaps)
