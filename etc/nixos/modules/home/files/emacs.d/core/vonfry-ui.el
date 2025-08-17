;;; core/vonfry-ui.el --- -*- lexical-binding: t; -*-
;;
;; Set emacs ui with the default variables and other theme.
;; The default theme is solarized.

(use-package solarized-theme
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
  "Change theme with disable current one.

THEME is a symbol passed to `load-theme'"
  (mapc
   (lambda (it)
     (when (memq it vonfry-themes)
       (disable-theme it)))
   custom-enabled-themes)
  (load-theme theme t))

(vonfry--change-theme (car vonfry-themes))

(defun vonfry/next-theme ()
  (interactive)
  (let* ((nxt (cdr (memq (car custom-enabled-themes) vonfry-themes)))
         (chthm (car (if nxt nxt vonfry-themes))))
    (vonfry--change-theme chthm)))

;; customize the tabbar and other UI elements for GUI.

;;
;; customize the fonts
;;

(defun vonfry--set-font (&optional frame)
  (set-face-font 'default "monospace-11" frame)
  (dolist (charset '(greek symbol))
    (set-fontset-font nil charset
                      "Noto Sans"
                      frame 'prepend))
  (dolist (charset '(symbol))
    (dolist (font '("Noto Sans Symbols-9" "Noto Sans Symbols 2-9"))
      (set-fontset-font nil charset font frame 'append)))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font nil charset
                      "Noto Sans CJK SC-9"
                      frame 'append)))

(defun vonfry--set-font-graphic ()
  (when (display-graphic-p) (vonfry--set-font)))

(add-hook (if (daemonp) 'server-after-make-frame-hook 'after-init-hook)
          'vonfry--set-font-graphic)

(setopt
  inhibit-startup-screen t
  inhibit-startup-echo-area-message nil

  display-time-default-load-average nil
  display-time-24hr-format t)

(display-time-mode 1)

(dolist (lst '(default-frame-alist initial-frame-alist))
  (add-to-list lst '(internal-border-width . 0)))

(add-hook 'term-mode-hook (lambda () (setq line-spacing 0)))

(defgroup vonfry-ui nil
  "Vonfry's Emacs ui custom group."
  :group 'vonfry)

(provide 'vonfry-ui)
