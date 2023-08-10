;;; core/core-ui.el -*- lexical-binding: t; -*-
;;
;; Set emacs ui with the default variables and other theme.
;; The default theme is solarized.

(use-package solarized
  :ensure solarized-theme
  :custom
  (solarized-use-variable-pitch nil)
  (solarized-scale-org-headlines nil)
  (solarized-scale-outline-headlines nil)
  (solarized-height-minus-1 1.0)
  (solarized-height-plus-1 1.0)
  (solarized-height-plus-2 1.0)
  (solarized-height-plus-3 1.0)
  (solarized-height-plus-4 1.0))

(use-package dracula-theme
  :custom
  (dracula-alternate-mode-line-and-minibuffer nil)
  (dracula-enlarge-headings nil)
  (dracula-height-title-1 1)
  (dracula-height-title-2 1)
  (dracula-height-title-3 1)
  (dracula-height-doc-title 1))

(defcustom vonfry-themes '(dracula solarized-light)
  "A list of theme which are used to switch by `vonfry/next-theme'"
  :type '(list symbol)
  :group 'vonfry-ui)

(defun vonfry--change-theme (theme)
  "change theme with disable current one.
THEME is a symbol passed to `load-theme'"
  (mapcar
   (lambda (it)
     (unless (equal it 'use-package)
       (disable-theme it)))
   custom-enabled-themes)
  (load-theme theme t))

(vonfry--change-theme (car vonfry-themes))

(defun vonfry/next-theme ()
  (interactive)
  (let* ((nxt (cdr (memq (car custom-enabled-themes) vonfry-themes)))
         (chthm (if nxt nxt (car vonfry-themes))))
    (vonfry--change-theme chthm)))

;; customize the tabbar and other UI elements for GUI.

;;
;; customize the fonts
;;

(defun vonfry--set-font (&optional frame)
  (set-face-font 'default "monospace-11" frame)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font nil charset
                      "Sarasa Mono SC-11"
                      frame 'append))
  (set-fontset-font nil 'unicode
                    "Symbola"
                    frame 'append)
  (dolist (charset '(greek symbol))
    (set-fontset-font nil charset
                      "Symbola"
                      frame 'prepend)))

(defun vonfry--set-font-graphic ()
  (when (display-graphic-p) (vonfry--set-font)))
(add-hook 'server-after-make-frame-hook 'vonfry--set-font-graphic)

(use-package info :ensure nil)

(setq-default
  inhibit-startup-screen t
  inhibit-startup-echo-area-message t

  display-time-default-load-average nil
  display-time-24hr-format t)

(display-time-mode 1)

(dolist (lst '(default-frame-alist initial-frame-alist))
  (add-to-list lst '(internal-border-width . 0)))

(add-hook 'term-mode-hook (lambda () (setq line-spacing 0)))

(defgroup vonfry-ui nil
  "vonfry's emacs ui custom group")

(provide 'vonfry-ui)
