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
;; quelpa and use-package both are provided a tools that download a package if it isn't installed. Why I shouldn't use
;; it? One of the reasons is that I don't know that when I am coding this configure. And another reason is I think both
;; file to manage different aim which can have a good file structure. I also download all the package at the first time
;; then load them. This can deal with some problem in plugins that they have a optional dependency but being coded
;; without after-load or a hook, which is the better safe method.

;;
;; define some variables for packages
;;

(defcustom vonfry-exclude-modules '()
  "This variables is used to the arguments for `vonfry-load-modules`"
  :group 'vonfry)

(defcustom vonfry-packages-dir (expand-file-name "packages/" vonfry-local-dir)
  "The dir is where the elpa and packages manager download files."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-elpa-dir (expand-file-name "elpa/" vonfry-packages-dir)
  "The dir is where the elpa files."
  :type 'directory
  :group 'vonfry-dir)

(defconst vonfry-modules-dir (expand-file-name "modules/" vonfry-config-dir))

(defcustom vonfry-private-modules-dir (expand-file-name "private/" vonfry-modules-dir)
  "Put your own modules here. Please don't set other modules without hook in this dir, becase the module loading order
is undefined(It always is loaded by alpha order)."
  :type 'directory
  :group 'vonfry-dir)

(defconst vonfry-pkg-manager "quelpa")

(defcustom vonfry-pkg-manager-dir (expand-file-name (concat vonfry-pkg-manager "/") vonfry-packages-dir)
  "Save that the package manager files."
  :type 'directory
  :group 'vonfry-dir)

;;
;; setup package manager
;;

(custom-set-variables
  '(package-user-dir          vonfry-elpa-dir)
  '(quelpa-dir                vonfry-pkg-manager-dir)
  '(quelpa-stable-p           nil)
  '(quelpa-checkout-melpa-p   t)
  '(quelpa-update-melpa-p     t)
  '(quelpa-upgrade-p          t)
  '(use-package-always-ensure nil))

(require 'package)
(package-initialize)
(package-refresh-contents)
(unless (require 'quelpa nil t)
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

;;
;; define function for packages
;;
(defalias #'vonfry/list-packages             #'list-packages)
(defalias #'vonfry/install-packages          #'quelpa)
(defalias #'vonfry/update-packages           #'quelpa-upgrade)
(defalias #'vonfry/update-pkgmanager         #'quelpa-self-upgrade)

(defmacro vonfry|package! (&rest pkg-info)
  "Define packages dependence and install it.

  Use this macro in packages.el.

  The args is sent to package manager as a list. If package manager cannot use it, use use-package with the first
element to download package from elpa without update. We should update by ourselves."
  (let ((ignore-case `(ignore-errors (or (quelpa '(,@pkg-info)) t))))
    `(unless ,ignore-case
      (package-install ',(car `(,@pkg-info))))))

(defalias #'vonfry|use-package! #'use-package)

;; load the basic packages
(dolist (pkg vonfry-basic-packages)
  (unless (require pkg nil t)
      (vonfry|package! pkg)
      (require pkg)))

(defun vonfry-load-module (module-name file)
  "This function load a module with two level name.

  module: The category of a module. It is the dir-name under modules.
  submodule: The name of a module. It is the dir-name under a module dir.

  This function finds module with the file, and loads it."

  (let* ((module-dir (expand-file-name module-name vonfry-modules-dir))
         (file-path (expand-file-name file module-dir)))
    (load file-path t)))

(defun vonfry-load-module-packages (module-name)
  (vonfry-load-module module-name "packages"))

(defun vonfry-load-module-config (module-name)
  (vonfry-load-module module-name "config"))

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

(defun vonfry-load-modules (&rest exclude)
  "This function load all modules exclude the modules/submodule(i.e. lang/haskell) name in arguments.

  All modules should use function and macro in this file. By default, every modules should have a file named
packages.el which is used to define the dependence with `vonfry-package!`. This file will be loaded at first for each
modules. After all modules' packages.el are loaded, it will load config.el which is used to configure for the module
which is the main file for a module.  Finally, the autoload.el will be loaded. It used to load some function for the
modules."
  (let* ((module-alist '())
         (regexp-exclude "^[^.].*"))
    (dolist (module (directory-files vonfry-modules-dir nil regexp-exclude))
        (dolist (submodule (directory-files (expand-file-name module vonfry-modules-dir) nil regexp-exclude))
          (let ((module-name (concat module "/" submodule)))
            (unless (member  module-name exclude))
              (push module-name module-alist))))
      (mapcar 'vonfry-load-module-packages module-alist)
      (mapcar 'vonfry-load-module-config module-alist)
      (mapcar 'vonfry-load-autoload module-alist)))

(provide 'core-packages)
