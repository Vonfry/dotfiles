;;; cc config -*- lexical-binding: t -*-
;;

;; +mmap-lang-cc-def
(vonfry-def-mmap-lang-prefix cc nil
  :keymaps '(c-mode-map c++-mode-map objc-mode-map))

;; +mmap-cc-def
(vonfry-def-mmap-leader-prefix cc nil
  :keymaps '(c-mode-map c++-mode-map objc-mode-map))

(defun +cc/lldb ()
  (interactive)
  (realgud--lldb "lldb"))
