;;; core.el --- the heart of the beast -*- lexical-binding: t; -*-

;;; Naming conventions:
;;
;;   vonfry-...   public variables or non-interactive functions
;;   vonfry--...  private anything (non-interactive), not safe for direct use
;;   vonfry/...   an interactive function; safe for M-x or keybinding
;;   vonfry:...   an evil operator, motion or command
;;   vonfry|...   hook function
;;   vonfry*...   advising functions
;;   ...!         a macro or function that configures Vonfry in modules
;;   %...         functions used for in-snippet logic
;;   +...         Any of the above but part of a module, e.g. `+emacs-lisp|init-hook'
;;
;; Autoloaded functions are in core/autoload/*.el and modules/*/*/autoload.el or
;; modules/*/*/autoload/*.el.
;;
;; core packages contain the main function and macros.
;; All plugins are in modules, load with use-package to deal with depence.
;;
;; Use `custom-set!` everywhere to config the varibles with defcustom. Only use `setq` somewhere the variables
;; are temporary such as debug configure.
;; Because `custom-set!` contains a lot of other behaviors such as set-after.

(require 'cl)

(defgroup vonfry nil
  "Vonfry's emacs group")

(defgroup vonfry-dir nil
  "Vonfry's emacs group about dir.")

(defcustom vonfry-config-dir user-emacs-directory
  "The dir to saves the configures."
  :type 'string
  :group 'vonfry-dir)

(defconst vonfry-core-dir (expand-file-name "core/" vonfry-config-dir)
  "The dir to saves the core module.")

(defcustom vonfry-debug nil
  "debug flag."
  :group 'vonfry
  :type 'boolean)

(if (or debug-on-error vonfry-debug)
  (progn
    (setq vonfry-debug t)
    (setq debug-on-error t))
  nil)

(require 'vonfry-local)

(when (file-exists-p vonfry-custom-file-before)
  (load vonfry-custom-file-before))

(require 'vonfry-packages)
(require 'vonfry-ui)
(require 'vonfry-editor)
(require 'vonfry-keybinding)
(require 'vonfry-os)
(require 'vonfry-func)

(defgroup vonfry-modules nil
  "Vonfry's emacs group about modules")

(vonfry-load-modules vonfry-exclude-modules)

(when (file-exists-p custom-file)
  (custom-save-all)
  (load custom-file))

(when (file-exists-p vonfry-custom-file-after)
  (load vonfry-custom-file-after))


(provide 'vonfry)
