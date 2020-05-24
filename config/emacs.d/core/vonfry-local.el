;;; core/core-local.el -*- lexical-binding: t; -*-
;;
;; Set some emacs files to local path.

;;
;; Set some variables
;;

(defcustom vonfry-local-dir (expand-file-name "local/" vonfry-config-dir)
  "The local dir saves the local files, which is different from cache file. These files is permanent."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-cache-dir (expand-file-name "emacs/" "~/.cache")
  "The local dir saves the caches files such as elpa or some plugins'. You can clean it and it will be reset by itself."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-custom-dir (expand-file-name "custom/" vonfry-config-dir)
  "The custom dir saves the local setting such as custom-file or some configures only can be used on this computer (jekyll, python path, etc.).
If you want to change some action in the default modules, you can use hook, custom-variables or other functions.
IMPORTANT!!! You must load the other files by youself. The only files under the dir named custom.el can be autoloaded."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-downloads-dir (expand-file-name "Downloads/" "~")
  "This is the dir for where you downloads files with eww or other tools. The default var is for macos where is your
user's downloads dir"
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-custom-file (expand-file-name "custom.el" vonfry-custom-dir)
  "custom for user's emacs"
  :type 'file
  :group 'vonfry-dir)

(defcustom vonfry-tramp-cache (expand-file-name "tramp/" vonfry-cache-dir)
  "tramp cache dir"
  :type 'file
  :group 'vonfry-dir)

(defcustom vonfry-custom-file-before (expand-file-name "pre-custom.el" vonfry-custom-dir)
  "custom for user's emacs. The file is loaded before core. You can set some variables at here which affect the configure in modules.  You can only custom the var in init file, I think."
  :type 'file
  :group 'vonfry-dir)

(defcustom vonfry-custom-file-after (expand-file-name "post-custom.el" vonfry-custom-dir)
  "custom for user's emacs. The file is loaded after custom. You can set some variables at here which affect the configure in modules.  You can only custom the var in init file, I think."
  :type 'file
  :group 'vonfry-dir)

(dolist (dir (list vonfry-cache-dir))
  (unless (file-exists-p dir)
    (make-directory dir)))

(defmacro vonfry-system-sets (&rest alist)
  "set with system type. The param is a list like (darwin (message \"darwin\") (message \"MacOS\")). The first element is system type and the other are the actions."
  (let ((actions
          (-non-nil (-reduce-from
                      (lambda (memo item)
                        (let* ((which-system (car item))
                               (actions      (cdr item)))
                          (if (eq system-type which-system)
                            (-concat memo actions)
                            memo)))
                      nil alist))))
    `(progn ,@actions)))

(defcustom vonfry-passwd-dir "~/.local/passwd"
  "a dir to save password"
  :type 'directory
  :group 'vonfry-dir)

(provide 'vonfry-local)
