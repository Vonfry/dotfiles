;;; agda config -*- lexical-binding: t -*-
;;

(defun +agda--mode-load ()
  "get agda-mode dir"
  (let ((mode-el (executable-find "agda-mode")))
    (when mode-el
      (load
       (with-output-to-string
        (call-process mode-el nil standard-output nil "locate"))))))
