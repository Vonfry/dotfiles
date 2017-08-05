;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; Define packages manager with quelpa and use-package.
;;
;; All modules save in format modules/submodule, the submodule in different module can have the same name. In a
;; submodule, packages.el, config.el and autoload file can be loaded automatically by the writting order. The other file
;; should be loaded in these file or by yourself.
;; packages.el define the dependence with `vonfry|package!`
;; config.el define the configure with `vonfry|use-package!`

;;
;; define some variables for packages
;;

(defcustom vonfry-exclude-modules '()
  "This variables is used to the arguments for `vonfry-load-modules`"
  :group 'vonfry)

(defconst vonfry-packages-dir (expand-file-name "packages/" vonfry-local-dir))

(defconst vonfry-elpa-dir (expand-file-name "elpa/" vonfry-packages-dir))

(defconst vonfry-modules-dir (expand-file-name "modules/" vonfry-config-dir))

(defconst vonfry-private-modules-dir (expand-file-name "private/" vonfry-modules-dir)
  "Put your own modules here. Please don't set other modules without hook in this dir, becase the module loading order
is undefined(It always is loaded by alpha order).")

(defconst vonfry-pkg-manager "quelpa")

(defconst vonfry-pkg-manager-dir (expand-file-name (concat vonfry-pkg-manager "/") vonfry-packages-dir))

;;
;; setup package manager
;;

(add-to-list 'load-path vonfry-pkg-manager-dir)

(custom-set-variables
  '(package-user-dir vonfry-elpa-dir)
  '(quelpa-stable-p nil)
  '(quelpa-dir vonfry-pkg-manager-dir))

(reuqire 'package)
(package-initialize)
(if (require 'quelpa nil t)
    (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;;
;; define some basic packages
;;

(defconst vonfry-basic-packages '(
    use-package ; package config
    general     ; keybind
    )
  "These are the default basic packages, which are used by modules.")

;; load the basic packages
(dolist (pkg vonfry-basic-packages)
  (require pkg))

;;
;; define function for packages
;;
(defalias #'vonfry/list-packages             #'list-packages)
(defalias #'vonfry/install-packages          #'quelpa)
(defalias #'vonfry/update-packages           #'quelpa-upgrade)
(defalias #'vonfry/update-pkgmanager         #'quelpa-self-upgrade)


(defalias #'vonfry-pkg-get                   #'quelpa)

(require 'cl)

(defmacro vonfry|packages! (&rest pkgs)
  "Define packages dependence and install it.
Use this function in packages.el"
  `(vonfry-pkg-get '(,@pkgs)))

(defalias #'vonfry|use-package! #'use-package)

(defun vonfry-load-module (module-name file)
  "This function load a module with two level name.

  module: The category of a module. It is the dir-name under modules.
  submodule: The name of a module. It is the dir-name under a module dir.

  This function finds module with the file, and loads it."

  (let* ((module-dir (expand-file-name module-name vonfry-modules-dir))
         (file-path (expand-file-name file module-dir)))
      (when (file-exists-p file-path)
        (load packages-path))))

(defun vonfry-load-module-packages (module-name)
  (vonfry-load-module module-name "packages")

(defun vonfry-load-module-config (module-name)
  (vonfry-load-module module-name "config")

(defun vonfry-load-autoload (module-name)
  "Load the autoload part in a path. It will load autoload.el, or files in autoload dir."
  (let* ((module-dir (expand-file-name module-name vonfry-modules-dir))
         (autoload-file (expand-file-name "autoload.el" module-dir))
         (autoload-dir (expand-file-name "autoload/" module-dir)))
    (when (file-exists-p autoload-file)
      (load autoload-file))
    (when (file-exists-p autoload-dir)
      (dolist (l (directory-files-recursively autoload-dir ".*"))
        (load l)))))

(defun vonfry-load-modules (&optional &rest exclude)
  "This function load all modules exclude the modules/submodule(i.e. lang/haskell) name in arguments.

  All modules should use function and macro in this file. By default, every modules should have a file named
packages.el which is used to define the dependence with `vonfry-package!`. This file will be loaded at first for each
modules. After all modules' packages.el are loaded, it will load config.el which is used to configure for the module
which is the main file for a module.  Finally, the autoload.el will be loaded. It used to load some function for the
modules."
  (let* ((module-alist '()))
    (dolist (module (directory-files vonfry-modules-dir))
      (dolist (submodules (directory-files (expand-file-name module vonfry-modules-dir)))
        (let (module-name (concat module "/" submodule))
          (unless (member  module-name exclude))
            (add-to-list 'module-alist module-name t))))
      (mapcar 'vonfry-load-module-packages module-alist)
      (mapcar 'vonfry-load-module-config module-alist)
      (mapcar 'vonfry-load-autoload module-alist)))

(provide 'core-packages)
