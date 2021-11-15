;;; agda config -*- lexical-binding: t -*-
;;

(defun +agda/setup ()
  "setup agda mode path due to the installation with nix in project instead of
globally."
  (interactive)
  (let ((agda-mode-exec (executable-find "agda-mode")))
    (when agda-mode-exec
      (load
        (with-temp-buffer
          (call-process agda-mode-exec nil t nil "locate")
          (buffer-string))))))

(defun +agda/generate-dir-local ()
  (interactive)
  (add-dir-local-variable nil 'eval
   '(add-hook 'envrc-mode-hook  '+agda/setup -100 t)))
