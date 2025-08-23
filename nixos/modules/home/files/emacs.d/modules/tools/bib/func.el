;;; bib/func.el --- -*- lexical-binding: t -*-
;;

(defun +bib/ebib-current ()
  (interactive)
  (ebib buffer-file-name))
