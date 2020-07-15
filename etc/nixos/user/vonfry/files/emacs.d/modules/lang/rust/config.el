;;; rust config -*- lexical-binding: t -*-
;;

;; +mmap-mode-rust-def
(mmap-mode-prefix! rust nil
  :keymaps 'rust-mode-map)

;; +mmap-rust-def
(mmap-leader-prefix! rust nil
  :keymaps 'rust-mode-map)

(fun! +rust/lldb ()
  (interactive)
  (realgud--lldb "rust-lldb"))
