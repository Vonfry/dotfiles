;;; cc config -*- lexical-binding: t -*-
;;

;; +nmap-lang-cc-def
(vonfry-def-nmap-lang-prefix cc nil
  :keymaps '(c-mode-map c++-mode-map objc-mode-map))

;; +nmap-cc-def
(vonfry-def-nmap-leader-prefix cc nil
  :keymaps '(c-mode-map c++-mode-map objc-mode-map))

(defun +cc/lldb ()
  (interactive)
  (realgud--lldb "lldb"))
