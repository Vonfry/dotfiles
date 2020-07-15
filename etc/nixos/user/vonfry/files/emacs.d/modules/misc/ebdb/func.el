;;; ebdb func -*- lexical-binding: t -*-
;;

(fun! +ebdb/create-new-record (path)
  (interactive "Fpath: ")
  (let ((s (make-instance 'ebdb-db-file :file path :dirty t)))
    (ebdb-db-save s)))
