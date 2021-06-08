;;; bib func -*- lexical-binding: t -*-
;;

(defun +bib/ebib-current ()
  (interactive)
  (ebib buffer-file-name))
