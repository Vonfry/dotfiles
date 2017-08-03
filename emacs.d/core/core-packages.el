;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; Define packages manager with el-get and use-package.
;;
;; All modules save in format modules/submodule, the submodule in different module can have the same name. In a
;; submodule, packages.el, config.el and autoload file can be loaded automatically by the writting order. The other file
;; should be loaded in these file or by yourself.
;; packages.el define the dependence with `vonfry-package!`
;; config.el define the configure with `vonfry-use-package!`

;;
;; define some variables for packages
;;

(defcustom vonfry-exclude-modules '()
  "This variables is used to the arguments for `vonfry-load-modules`")

(defconst vonfry-packages-dir (expand-file-name "packages" vonfry-local-dir))

(defconst vonfry-modules-dir (expand-file-name "modules" vonfry-config-dir))

(defconst vonfry-private-modules-dir (expand-file-name "private" vonfry-modules-dir)
  "Put your own modules here. Please don't set other modules without hook in this dir, becase the module loading order
is undefined(It always is loaded by alpha order).")

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
;; define some basic packages
;;

(defconst vonfry-basic-packages
  '(use-package)
  "These are the default basic packages, which are used by modules.")

(el-get 'sync vonfry-basic-packages)

;; load the basic packages
(dolist (pkg vonfry-basic-packages)
  (require pkg))

;;
;; define function for packages
;;

(defalias #'vonfry/list-packages             #'el-get-list-packages)
(defalias #'vonfry/install-packages          #'el-get-install)
(defalias #'vonfry/update-packages           #'el-get-update)
(defalias #'vonfry/update-all-packages       #'el-get-update-all)
(defalias #'vonfry/update-el-get             #'el-get-self-update)
(defalias #'vonfry/remove-package            #'el-get-remove)
(defalias #'vonfry/reinstall-package         #'el-get-reinstall)
(defalias #'vonfry/reload-packages           #'el-get-reload)
(defalias #'vonfry/describe-package          #'el-get-describe)
(defalias #'vonfry/find-recipe-file-packages #'el-get-find-recipe-file)

(defalias #'vonfry-pkg-get                   #'el-get)

(require 'cl)

(defun vonfry-package! (&rest pkgs)
  "Define packages dependence and install it.
Use this function in packages.el"
  (vonfry-pkg-get 'sync pkgs))
  nil)

(defalias #'vonfry-use-package! #'use-package)

(defun vonfry-load-module (module submodule)
  "This function load a module with two level name.

  module: The category of a module. It is the dir-name under modules.
  submodule: The name of a module. It is the dir-name under a module dir.

  This function finds module with the two name, and loads its packages.el, config.el and autoload file with `load`."

  (let* ((module-dir (expand-file-name module vonfry-modules-dir))
         (submodule-dir (expand-file-name submodule module-dir))
         (packages-path (expand-file-name "packages" submodule-dir))
         (config-path (expand-file-name "config" submodule-dir)))
      (when (file-exists-p packages-path)
        (load packages-path))
      (when (file-exists-p config-path)
        (load config-path))
      (vonfry-load-autoload submodule-dir)))

(defun vonfry-load-autoload (path)
  "Load the autoload part in a path. It will load autoload.el, or files in autoload dir."
  (let ((autoload-file (expand-file-name "autoload.el" path))
        (autoload-dir (expand-file-name "autoload/" path)))
    (when (file-exists-p autoload-file)
      (load autoload-file))
    (when (file-exists-p autoload-dir)
      (dolist (l (directory-files-recursively autoload-dir ".*"))
        (load l)))))

(defun vonfry-load-modules (&optional &rest exclude)
  "This function load all modules exclude the modules/submodule(i.e. lang/haskell) name in arguments.

  All modules should use function and macro in this file. By default, every modules should have a file named
packages.el which is used to define the dependence with `vonfry-package!`. This file will be loaded at first for each
modules. Then it will load config.el which is used to configure for the module which is the main file for a module.
Finally, the autoload.el will be loaded. It used to load some function for the modules."

  (dolist (module (directory-files vonfry-modules-dir))
    (dolist (submodules (directory-files (expand-file-name module vonfry-modules-dir)))
      (when `(not (or ,@(mapcar (lambda (m) (eq (concat module "/" submodules) m)) exclude)))
        (vonfry-load-module module submodule)))))

(provide 'core-packages)
