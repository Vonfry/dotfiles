;;; core/core-local.el -*- lexical-binding: t; -*-
;;
;; Set some emacs files to local path.

;;
;; Set some variables
;;

(defcustom vonfry-local-dir (expand-file-name "local/" vonfry-config-dir)
  "The local dir saves the temporary files such as elpa or some plugins'. You can clean it and it will be reset by
itself."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-temp-dir (expand-file-name "temp/" vonfry-local-dir)
  "The local dir saves the temporary files such as elpa or some plugins'. You can clean it and it will be reset by
itself."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-custom-dir (expand-file-name "custom/" vonfry-config-dir)
  "The custom dir saves the local setting such as custom-file or some configures only can be used on this computer
(jekyll, python path, etc.).

  If you want to change some action in the default modules, you can use hook, custom-variables or other functions.

  IMPORTANT!!! You must load the other files by youself. The only files under the dir named custom.el can be
autoloaded."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-downloads-dir (expand-file-name "Downloads/" "~")
  "This is the dir for where you downloads files with eww or other tools. The default var is for macos where is your
user's downloads dir"
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-org-dir (expand-file-name ".org/" "~")
  "User's own org files saving things like capture or agents."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-custom-file (expand-file-name "custom.el" vonfry-custom-dir)
  "custom for user's emacs"
  :type 'file
  :group 'vonfry-dir)

(unless (file-exists-p vonfry-temp-dir)
  (make-directory vonfry-temp-dir))

(custom-set-variables
  '(custom-file vonfry-custom-file))

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
