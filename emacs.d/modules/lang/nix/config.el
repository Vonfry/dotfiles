;;; nix config -*- lexical-binding: t -*-
;;

(defconst +nix-keymaps 'nix-mode-map)

;; +nmap-lang-nix-def
(vonfry-def-nmap-lang-prefix nix nil
  :keymaps +nix-keymaps)
