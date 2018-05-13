;;; autoload - func -*- lexical-binding: -*-

(defun vonfry/compile-init-files ()
  "compile init files.

  This function will remove all compiled files, and recompile them.

  If you want to remove them, run in shell, find . -name *.elc | parallel rm"
  (interactive)
  (mapcar
    (lambda (f) (delete-file f nil))
    (directory-files-recursively vonfry-config-dir "^.*\\.elc$"))
  (mapcar
    (lambda (f) (byte-compile-file f))
    (directory-files-recursively vonfry-config-dir "^.*\\.el$")))
