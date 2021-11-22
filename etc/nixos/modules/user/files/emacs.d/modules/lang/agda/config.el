;;; agda config -*- lexical-binding: t -*-
;;

(defun +agda/setup ()
  "setup agda mode path due to the installation with nix in project instead of
globally."
  (interactive)
  (let* ((agda-mode-exec (executable-find "agda-mode"))
         (agda-exec (directory-file-name (file-name-directory agda-mode-exec))))
    (when agda-mode-exec
      (add-to-list 'exec-path agda-exec)
      (load
        (with-output-to-string
          (call-process agda-mode-exec nil standard-output nil "locate"))))))

(defun +agda/unload ()
  "unload agda mode to let us setup next agda version."
  (interactive)
  (dolist (feat '(agda2-queue agda2-abbrevs agda2-highlight
                  agda-input agda2-mode agda2))
    (unload-feature feat t)))
