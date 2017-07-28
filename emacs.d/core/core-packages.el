;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; set packages manager with el-get.

;;
;; define some variables for packages
;;
(defconst vonfry-packages-path (expand-file-name "packages" vonfry-local-path))
(defconst vonfry-el-get-path (expand-file-name "el-get" vonfry-packages-path))
(defconst vonfry-el-get-user-path (expand-file-name "el-get-user" vonfry-local-path))
(defconst vonfry-el-get-recipe-path (expand-file-name "repice" vonfry-el-get-user-path))
;;
;; setup el-get
;;
(add-to-list 'load-path vonfry-el-get-path)

;; set el-get variables
(custom-set-variables
  '(package-user-dir vonfry-packages-path)
  '(el-get-dir vonfry-el-get-path))

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path vonfry-el-get-recipe-path)
(el-get 'sync)

;;
;; define function for packages
;;

(defun vonfry-load-modules ()
  "load all modules in modules directory. The private modules will be load at first."
  )

;;
;; install some basic packages
;;

(provide 'core-packages)
