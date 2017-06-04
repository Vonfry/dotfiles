(require-package 'solarized-theme)
(load-theme 'solarized-dark t)

;; Changing font sizes
(require-package 'default-text-scale)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

;; Setting English Font
(set-face-attribute
 'default nil :font "Hack 11")
;; Chinese Font 配制中文字体
(defmacro chinese-font (font-name font-size)
  `(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family ,font-name :size ,font-size))))
(if *is-a-mac*
  (chinese-font "Hei" 11)
  f)

(setq display-time-format "%T")
(display-time-mode 1)

(require-package 'winum)
(setq winum-auto-setup-mode-line nil)
(winum-mode)

(require-package 'info+)
(with-eval-after-load 'info
  (require 'info+))

(provide 'init-theme)
