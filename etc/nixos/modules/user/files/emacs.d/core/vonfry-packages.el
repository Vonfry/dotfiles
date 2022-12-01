;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; Define packages manager with use-package.
;;
;; All modules save in format modules/submodule, the submodule in different module can have the same name. In a
;; submodule, config.el, packages.el and func.el file can be loaded automatically by the writting order. The other file
;; should be loaded in these file or by yourself.
;; config.el define custom, const and other varible for configure.
;; packages.el define the dependence and default configure with `use-package'
;; func.el define autoload funciotns which is suggested to saved under a dir named autoload.
;;
;; use-package provide a tools that download a package if it isn't installed.;;

;; define some variables for packages
;;
;; Use `setq-default' everywhere to config the varibles with defcustom before
;; package is loaded. This can avoid saving value into `custom-file'.
;; In other words, you should custom modules in `vonfry-custom-file-before'
;; which is loaded before all modules.
;; If you want to custom the variables in core, You should define them into
;;`custom-file', which is loaded at first.
;; If you want to custom variables setting in modules with use-package, you can
;; use `use-package-inject-hooks' with post-init.

(defcustom vonfry-exclude-modules '()
  "This variables is used to the arguments for `vonfry-load-modules`"
  :type '(repeat string)
  :group 'vonfry)

(defconst vonfry-modules-dir (expand-file-name "modules/" vonfry-config-dir))

(defcustom vonfry-package-ensure
  (not (or (executable-find "nixos-rebuild") (executable-find "home-manager")))
  "Whether ensure package is installed by emacs.
If t, package.el is used to install packages automatically."
  :type 'boolean
  :group 'vonfry)

(setq-default
 ;; nix replaces package.el to manage but we also set it.
 package-user-dir (expand-file-name "packages" vonfry-local-dir)
 use-package-always-demand t
 use-package-always-ensure vonfry-package-ensure)

(when (and (boundp 'native-comp-eln-load-path)
           (fboundp 'startup-redirect-eln-cache))
  (startup-redirect-eln-cache (expand-file-name "eln/" vonfry-cache-dir)))

;;
;; define some basic packages
;;

(defconst vonfry-basic-packages '(
    use-package
    ;; many package load org directly without eval-after-load, so add it here
    ;; to make sure the newest is used.
    org
  )
  "These are the default basic packages, which are used by modules.")

(package-initialize)

;; load the basic packages
(dolist (pkg vonfry-basic-packages)
  (let ((qpkg `(quote ,pkg)))
    (eval `(require ,qpkg))))

(use-package diminish)
(use-package dash)
(use-package s)

(defun vonfry-load-module (module-name file)
  "This function load a module with two level name.

module: The category of a module. It is the dir-name under modules.
submodule: The name of a module. It is the dir-name under a module dir.

This function finds module with the file, and loads it."

  (let* ((module-dir (expand-file-name module-name vonfry-modules-dir))
         (file-path (expand-file-name file module-dir)))
    (load file-path t t)))

(defun vonfry-load-module-packages (module-name)
  (vonfry-load-module module-name "packages"))

(defun vonfry-load-module-config (module-name)
  (vonfry-load-module module-name "config"))

(defun vonfry-load-autoload (module-name)
  (vonfry-load-module module-name "func"))

(defun vonfry-load-modules (&rest exclude)
  "This function load all modules exclude the modules/submodule(i.e. lang/haskell) name in arguments.

All modules should use function and macro in this file. By default, every modules should have a file named packages.el which is used to define the dependence with `use-package`. This file will be loaded at first for each modules. After all modules' packages.el are loaded, it will load config.el which is used to configure for the module which is the main file for a module.  Finally, the autoload.el will be loaded. It used to load some function for the modules."
  (let* ((flatten-exclude (-flatten exclude))
         (module-list '())
         (regexp-match "^[^\\.].*"))
    (dolist (module (directory-files vonfry-modules-dir nil regexp-match))
        (dolist (submodule (directory-files (expand-file-name module vonfry-modules-dir) nil regexp-match))
          (let ((module-name (concat module "/" submodule)))
            (unless (member module-name flatten-exclude)
              (push module-name module-list)))))
    (-map 'vonfry-load-module-config   module-list)
    (-map 'vonfry-load-module-packages module-list)
    (-map 'vonfry-load-autoload        module-list)))

(provide 'vonfry-packages)
