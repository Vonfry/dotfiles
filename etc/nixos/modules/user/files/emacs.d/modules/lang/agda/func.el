;;; agda func -*- lexical-binding: t -*-
;;

(defun +agda/setup ()
  "setup agda mode path due to the installation with nix in project instead of
globally."
  (let ((agda-mode-exec (executable-find "agda-mode")))
    (when agda-mode-exec
      (load
        (with-temp-buffer
          (call-process agda-mode-exec nil t nil "locate")
          (buffer-string))))))
