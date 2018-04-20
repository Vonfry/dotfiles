;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; Define packages manager with quelpa and use-package.
;;
;; All modules save in format modules/submodule, the submodule in different module can have the same name. In a
;; submodule, packages.el, config.el and autoload file can be loaded automatically by the writting order. The other file
;; should be loaded in these file or by yourself.
;; packages.el define the dependence with `package!`
;; config.el define the configure with `use-package!`
;;
;; quelpa and use-package both are provided a tools that download a package if it isn't installed. Why I shouldn't use
;; it? One of the reasons is that I don't know that when I am coding this configure. And another reason is I think both
;; file to manage different aim which can have a good file structure. I also download all the package at the first time
;; then load them. This can deal with some problem in plugins that they have a optional dependency but being coded
;; without after-load or a hook, which is the better safe method.

;;
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
  '(use-package-always-ensure nil))

(require 'package)
(setq package-archives vonfry-elpa-mirror)
(package-initialize)

;;
;; define some basic packages
;;

(defconst vonfry-basic-packages '(
    use-package
    general
    package-utils
    paradox
    diminish
    )
  "These are the default basic packages, which are used by modules.")

;;
;; define function for packages
;;
(defalias #'vonfry/list-packages       #'paradox-list-packages)
(defalias #'vonfry/install-packages    #'package-install)
(defalias #'vonfry/update-packages     #'package-utils-upgrade-by-name)
(defalias #'vonfry/update-all-packages #'package-utils-upgrade-all)

(defmacro package! (pkg &optional min-version no-refresh)
  "Define packages dependence and install it.

  Use this macro in packages.el.

  pkg is the name of the package.
  min-version is a list of the package's minimum version. See more `version-list<=`.
  no-refresh is not nil, it will refresh the `package-archive-content` before install."
  `(vonfry--package! ',pkg ',min-version ,no-refresh))

(defun vonfry--package! (pkg &optional min-version no-refresh)
  "Define packages dependence and install it.

  This is a private function. It is called in macro `package!`. Why use macro please see this macro's document."
    (if (package-installed-p pkg min-version)
      t
      (if (or (assoc pkg package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
          (package-install pkg nil)
          (package-install pkg))
        (progn
          (package-refresh-contents)
          (vonfry--package! pkg min-version t)))))

(defalias #'use-package! #'use-package)

;; load the basic packages
(dolist (pkg vonfry-basic-packages)
  (unless (require pkg nil t)
      (vonfry--package! pkg)
      (require pkg)))

(use-package! paradox :config (paradox-enable))
(use-package! package-utils)

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
packages.el which is used to define the dependence with `package!`. This file will be loaded at first for each
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
