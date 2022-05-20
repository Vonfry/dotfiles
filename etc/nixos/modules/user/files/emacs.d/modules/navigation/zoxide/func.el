;;; zoxide func -*- lexical-binding: t -*-
;;

(defun +zoxide-fzf ()
  (interactive)
  (let ((zoxide-find-file-function #'counsel-fzf))
    (zoxide-find-file)))
