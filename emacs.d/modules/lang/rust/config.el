;;; rust config -*- lexical-binding: t -*-
;;

;; +nmap-lang-rust-def
(vonfry-def-nmap-lang-prefix rust nil
  :keymaps 'rust-mode-map)

;; +nmap-rust-def
(vonfry-def-nmap-leader-prefix rust nil
  :keymaps 'rust-mode-map)

(defun +rust/lldb ()
  (interactive)
  (realgud--lldb "rust-lldb"))
