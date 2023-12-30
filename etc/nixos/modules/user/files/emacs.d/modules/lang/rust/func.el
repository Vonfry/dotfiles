;;; rust/func.el --- -*- lexical-binding: t -*-
;;

(defun +rust/lldb ()
  (interactive)
  (realgud--lldb "rust-lldb"))

(defun +rust/gdb ()
  (interactive)
  (realgud:gdb "rust-gdb"))
