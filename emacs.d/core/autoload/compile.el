;;; autoload - func -*- lexical-binding: -*-

(defun vonfry/compile-init-files ()
  "compile init files.

  This function will remove all compiled files, and recompile them.

  If you want to remove them, run in shell, find . -name *.elc | parallel rm"
  (interactive)
  (byte-recompile-directory vonfry-config-dir nil t))
