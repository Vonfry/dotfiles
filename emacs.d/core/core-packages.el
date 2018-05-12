;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; Define packages manager with use-package.
;;
;; All modules save in format modules/submodule, the submodule in different module can have the same name. In a
;; submodule, config.el, packages.el and func.el file can be loaded automatically by the writting order. The other file
;; should be loaded in these file or by yourself.
;; config.el define custom, const and other orvarible for configure .
;; packages.el define the dependence and default configure with `package!`
;; func.el define autoload funciotns which is suggested to saved under a dir named autoload.
;;
;; use-package provide a tools that download a package if it isn't installed.;;
;;
;; auto-package-update is used by default, but `auto-package-update-maybe` is not called in the config.

;; define some variables for packages
;;

(defcustom vonfry-elpa-mirror
  (list
    (cons "elpa"  "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    (cons "melpa" "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
    (cons "org"   "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/"))
  "Set elpa mirror."
  :group 'vonfry)

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

;;
;; setup package manager
;;

(custom-set-variables
  '(package-user-dir vonfry-elpa-dir)
  '(use-package-always-demand t)
  '(use-package-always-ensure t))

(require 'package)
(setq package-archives vonfry-elpa-mirror)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;;
;; define some basic packages
;;

(defconst vonfry-basic-packages '(
    use-package
  )
  "These are the default basic packages, which are used by modules.")

;;
;; define function for packages
;;
(defalias #'vonfry/list-packages       #'paradox-list-packages)
(defalias #'vonfry/install-packages    #'package-install)
(defalias #'vonfry/update-packages     #'package-utils-upgrade-by-name)
(defalias #'vonfry/update-all-packages #'package-utils-upgrade-all)

(defun vonfry--package! (pkg &optional min-version no-refresh)
  "Define packages dependence and install it.

  This is a private function. It is only used in core."
    (if (package-installed-p pkg min-version)
      t
      (if (or (assoc pkg package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
          (package-install pkg nil)
          (package-install pkg))
        (progn
          (package-refresh-contents)
          (vonfry--package! pkg min-version t)))))

(defalias #'package! #'use-package)

(defun autoload! (func file &optional interactive docstring type)
  "autoload file with current load file dir which is called in submodules.

  Note: the &optional arguments has some different from `autoload`."
  (let* ((current-dir (file-name-directory load-file-name))
         (autoload-dir (expand-file-name)))
    (autoload func file docstring interactive type)))

;; load the basic packages
(dolist (pkg '(use-package))
  (unless (require pkg nil t)
      (vonfry--package! pkg)
      (require pkg)))

(package! package-utils)
(package! paradox :config (paradox-enable))
(package! diminish)
(package! dash)
(package! auto-package-update
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t))

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
  (vonfry-load-module module-name "func"))

(defun vonfry-load-modules (&rest exclude)
  "This function load all modules exclude the modules/submodule(i.e. lang/haskell) name in arguments.

  All modules should use function and macro in this file. By default, every modules should have a file named
packages.el which is used to define the dependence with `package!`. This file will be loaded at first for each
modules. After all modules' packages.el are loaded, it will load config.el which is used to configure for the module
which is the main file for a module.  Finally, the autoload.el will be loaded. It used to load some function for the
modules."
  (let* ((module-alist '())
         (regexp-match "^[^\\.].*"))
    (dolist (module (directory-files vonfry-modules-dir nil regexp-match))
        (dolist (submodule (directory-files (expand-file-name module vonfry-modules-dir) nil regexp-match))
          (let ((module-name (concat module "/" submodule)))
            (unless (member  module-name exclude))
              (push module-name module-alist))))
      (mapcar 'vonfry-load-module-config module-alist)
      (mapcar 'vonfry-load-module-packages module-alist)
      (mapcar 'vonfry-load-autoload module-alist)))

(provide 'core-packages)
