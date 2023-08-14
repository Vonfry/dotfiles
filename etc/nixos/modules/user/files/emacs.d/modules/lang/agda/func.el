;;; agda func -*- lexical-binding: t -*-
;;

(defun +agda2--ensure-unload ()
  "Unload agda features and remove its path from `load-path'."
  (unless (equal +agda2--init-directory agda2-directory)
    (delete agda2-directory 'load-path))
  (dolist (feat (agda2-mode agda2-abbrevs agda2-highlight agda2-mode-pkg
                 agda2-queue agda-input eri annotation agda2
                 agda-mode-autoloads))
    (when (featurep feat)
      (unload-feature feat))))

(defun +agda2--locate ()
  (let ((agda-exec (executable-find "agda-mode")))
    (when adga-exec
      (with-temp-buffer
        (when (equal 0 (call-process agda-exec nil t nil "locate"))
          (buffer-string))))))

(defun +agda2-reload ()
  "Bacuse agda-mode is distributed with special agda version, reload the agda2
mode from current environment instead of default installed one."
  (interactive)
  (+agda2--ensure-unload)
  (let ((locate (+agda2--locate)))
    (if locate
        (load locate)
      (require 'agda2))))
