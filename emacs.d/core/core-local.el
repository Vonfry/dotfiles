;;; core/core-local.el -*- lexical-binding: t; -*-
;;
;; Set some emacs files to local path.

;;
;; Set some variables
;;

(defconst vonfry-local-dir (expand-file-name "local/" vonfry-config-dir)
  "The local dir saves the temporary files such as elpa or some plugins'. You can clean it and it will be reset by
itself.")

(defconst vonfry-custom-dir (expand-file-name "custom/" vonfry-local-dir)
  "The custom dir saves the local setting such as custom-file or some configures only can be used on this computer
(jekyll, python path, etc.).

  If you want to change some action in the default modules, you can use hook, custom-variables or other functions.

  IMPORTANT!!! You must load the other files by youself. The only files under the dir named custom.el can be
autoloaded.")

(defcustom vonfry-downloads-dir (expand-file-name "Downloads/" "~")
  "This is the dir for where you downloads files with eww or other tools. The default var is for macos where is your
user's downloads dir"
  :group 'vonfry-dir)


(defconst vonfry-custom-file (expand-file-name "custom.el" vonfry-local-dir))

(custom-set-variables
  '(custom-file vonfry-custom-file)
  )

(defun vonfry-system-sets (&rest alist)
  "set with system type. The param is a list like (darwin (message \"darwin\") (message \"MacOS\")). The first element
is system type and the other are the actions."
  (let* ((fst (car alist))
         (lst (cdr alist))
         (which-system (car fst))
         (actions      (cdr fst)))
    (if (eq system-type which-system)
      (dolist (act actions)
        (eval act))
      (vonfry-system-sets lst))))

(provide 'core-local)
