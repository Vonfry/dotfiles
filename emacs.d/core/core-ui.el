;;; core/core-ui.el -*- lexical-binding: t; -*-
;;
;; Set emacs ui with the default variables and other theme.
;; The default theme is solarized.

(vonfry-package! 'all-the-icons)

(vonfry-package! 'solarized-theme)
(vonfry-use-package! 'solarized-dark
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

(vonfry-package! 'info+)
(vonfry-use-package! 'info+
  :init
  (vonfry-use-package! info))

(custom-set-variables
  '(display-time-24hr-format t))
(display-time-mode t)

(provide 'core-ui)
