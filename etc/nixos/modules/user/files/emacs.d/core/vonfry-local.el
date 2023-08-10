;;; core/core-local.el -*- lexical-binding: t; -*-
;;
;; Set some emacs files to local path.

;;
;; Set some variables
;;

(defgroup vonfry nil
  "Vonfry's emacs group")

(defcustom vonfry-config-dir user-emacs-directory
  "The dir to saves the configures."
  :type 'string
  :group 'vonfry)

(defconst vonfry-core-dir (expand-file-name "core/" vonfry-config-dir)
  "The dir to saves the core module.")

(require 'xdg)

(defconst vonfry-local-dir (expand-file-name "emacs/" (xdg-data-home))
  "The local dir saves the local files, which is different from cache file. These files is permanent.")

(defconst vonfry-cache-dir (expand-file-name "emacs" (xdg-cache-home))
  "The local dir saves the caches files such as elpa or some plugins'. You can clean it and it will be reset by itself.")

(defconst vonfry-custom-dir (expand-file-name "local/" vonfry-config-dir)
  "The custom dir saves the local setting such as custom-file or some configures only can be used on this computer (jekyll, python path, etc.).
If you want to change some action in the default modules, you can use hook, custom-variables or other functions.
IMPORTANT!!! You must load the other files by youself. The only files under the dir named custom.el can be autoloaded.")

(defconst vonfry-custom-file (expand-file-name "custom.el" vonfry-custom-dir)
  "custom for user's emacs")

(defconst vonfry-custom-file-before (expand-file-name "pre-custom.el" vonfry-custom-dir)
  "custom for user's emacs. The file is loaded before core. You can set some variables at here which affect the configure in modules.  You can only custom the var in init file, I think.")

(defconst vonfry-custom-file-after (expand-file-name "post-custom.el" vonfry-custom-dir)
  "custom for user's emacs. The file is loaded after custom. You can set some variables at here which affect the configure in modules.  You can only custom the var in init file, I think.")

(dolist (dir (list vonfry-cache-dir vonfry-local-dir vonfry-custom-dir))
  (unless (file-exists-p dir)
    (make-directory dir t)))

(setq-default custom-file vonfry-custom-file)

(provide 'vonfry-local)
