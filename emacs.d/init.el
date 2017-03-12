;; Package with melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq *init-dir* (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path *init-dir*)


(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defconst *is-a-mac* (eq system-type 'darwin))


;; require submodules
(require 'init-theme)
(require 'init-gui)
(require 'init-neotree)
(require 'init-helm)
(require 'init-ibuffer)
(require 'init-uniquify)
(require 'init-flycheck)
(require 'init-semantic)
(require 'init-imenu)

(require 'init-company)
(require 'init-mmm-mode)

(require 'init-edit)
(require 'init-whitespace)

(require 'init-vc)
(require 'init-git)

(require 'init-projectile)

(require 'init-tags)
(require 'init-language)
(require 'init-docker)
(require 'init-pdf)

(require 'init-macos)
(require 'init-evil)

(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fic-highlighted-words (quote ("FIXME" "TODO" "BUG" "KLUDGE" "IMPORTANT")))
 '(package-selected-packages
   (quote
    (company-inf-ruby company-anaconda yaml-mode company-arduino arduino-mode rainbow-mode kurecolor bundler cmake-mode solarized-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
