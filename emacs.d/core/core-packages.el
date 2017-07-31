;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; set packages manager with el-get.

;;
;; define some variables for packages
;;

(defcustom vonfry-exclude-modules nil
  "This variables is used to the arguments for `vonfry-load-modules`"
  )

(defconst vonfry-packages-dir (expand-file-name "packages" vonfry-local-dir))

(defconst vonfry-modules-dir (expand-file-name "modules" vonfry-config-dir))

(defconst vonfry-private-dir (expand-file-name "private" vonfry-modules-dir)
  "The private dir under modules is used to set the modules which are not in this project. It will be loaded at first.
If you want set some variables after some plugins, please use `with-eval-after-load` or some hook, but I suggest use
`custom-set-variables` to config them, because they are safer.")

(defconst vonfry-el-get-dir (expand-file-name "el-get" vonfry-packages-dir))

(defconst vonfry-el-get-user-dir (expand-file-name "el-get-user" vonfry-local-dir))

(defconst vonfry-el-get-recipe-dir (expand-file-name "repice" vonfry-el-get-user-dir))

;;
;; setup el-get
;;

(add-to-list 'load-path vonfry-el-get-dir)

;; set el-get variables
(custom-set-variables
  '(package-user-dir vonfry-packages-dir)
  '(el-get-dir vonfry-el-get-dir))

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path vonfry-el-get-recipe-dir)
(el-get 'sync)

;;
;; define function for packages
;;

(require 'cl)

(defun vonfry-load-modules (&rest &optional exclude)
  "This function load all modules"
  )

(provide 'core-packages)
