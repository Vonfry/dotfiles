;;; core/core-ui.el -*- lexical-binding: t; -*-
;;
;; Set emacs ui with the default variables and other theme.
;; The default theme is solarized.

(vonfry|packages! all-the-icons)
(vonfry|use-package! all-the-icons)

(vonfry|packages! solarized-theme)
(vonfry|use-package! solarized-dark
  :config
  (load-theme 'solarized-dark-theme	t))

;; customize the tabbar and other UI elements for GUI.

;;
;; customize the fonts
;;

(set-face-attribute 'default nil :font "Hack 11")

;; Chinese Font 配制中文字体
(defmacro chinese-font (font-name font-size)
  `(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family ,font-name :size ,font-size))))

(vonfry-system-set '(darwin (chinese-font "Hei" 11)))

(vonfry|packages! info+)
(vonfry|use-package! info+
  :init
  (vonfry|use-package! info))

(custom-set-variables
  '(tool-bar-mode nil)

  '(display-time-24hr-format t)

  '(use-file-dialog nil)
  '(use-dialog-box nil)
  '(inhibit-startup-screen t)
  '(inhibit-startup-echo-area-message t))

(display-time-mode t)

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(add-hook 'after-make-frame-functions
  (lambda (frame)
    (with-selected-frame frame
      (unless window-system
        (set-frame-parameter nil 'menu-bar-lines 0)))))

(add-hook 'after-make-frame-functions
  (lambda ()
    (modify-frame-parameters frame
      '((vertical-scroll-bars . nil)
        (horizontal-scroll-bars . nil)))))

(add-hook 'term-mode-hook
  (lambda ()
    (setq line-spacing 0)))

(provide 'core-ui)
