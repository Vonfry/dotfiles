;;; smex packages -*- lexical-binding: t -*-
;;

(package! smex
  :custom
  (smex-save-file (expand-file-name "smex-items" vonfry-local-dir))
  :hook (after-init .
    (lambda ()
      (let ((smex-file (expand-file-name "smex-items" vonfry-config-dir)))
        (if (file-exists-p smex-file)
          (delete-file smex-file))))))
