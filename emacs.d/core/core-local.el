;;; core/core-local.el -*- lexical-binding: t; -*-
;;
;; Set some emacs files to local path.
;;
;;

;;
;; Set some variables
;;
(defcustom vonfry-config-dir user-emacs-directory
  "The dir to saves the configures."
  :type 'string)

(defcustom vonfry-core-dir (expand-file-name "core" vonfry-config-dir)
  "The dir to saves the core module."
  :type 'string)

(defconst vonfry-local-dir (expand-file-name "local" vonfry-config-dir)
  "The local dir saves the temporary files such as elpa, auto-save-list-file or some plugins'. You can clean it and it
will be reset by itself.")

(defconst vonfry-custom-dir (expand-file-name "custom" vonfry-local-dir)
  "The custom dir saves the local setting such as custom-file or some configures only can be used on this computer
(jekyll, python path, etc.).

  If you want to change some action in the default modules, you can use hook, custom-variables or other functions.

  IMPORTANT!!! You must load the other files by youself. The only files under the dir named custom.el can be
autoloaded.")

(defconst vonfry-custom-file (expand-file-name "custom.el" vonfry-local-dir))

(custom-set-variables
  '(auto-save-list-file-prefix (expand-file-name "saves-" vonfry-local-dir))
  '(custom-file vonfry-custom-file)
  )

(provide 'core-local)
