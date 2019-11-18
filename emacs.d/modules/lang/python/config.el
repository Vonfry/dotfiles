;;; python config -*- lexical-binding: t -*-
;;

(defconst +python-keymaps 'python-mode-map)

;; +nmap-lang-python-def
(vonfry-def-nmap-lang-prefix python nil
  :keymaps +python-keymaps)

;; +nmap-python-def
(vonfry-def-nmap-leader-prefix python nil
  :keymaps +python-keymaps)
