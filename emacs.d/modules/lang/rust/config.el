;;; rust config -*- lexical-binding: t -*-
;;

;; +mmap-mode-rust-def
(vonfry-def-mmap-mode-prefix rust nil
  :keymaps 'rust-mode-map)

;; +mmap-rust-def
(vonfry-def-mmap-leader-prefix rust nil
  :keymaps 'rust-mode-map)

(defun +rust/lldb ()
  (interactive)
  (realgud--lldb "rust-lldb"))
