;;; core/core-ui.el -*- lexical-binding: t; -*-
;;
;; Set emacs ui with the default variables and other theme.
;; The default theme is solarized.

(package! all-the-icons) ;; M-x all-the-icons-install-fonts and the run (fc-cache -f -v) with shell

(package! solarized
  :straight solarized-theme
  :config
  (load-theme 'solarized-dark t))

;; customize the tabbar and other UI elements for GUI.

;;
;; customize the fonts
;;

(if window-system
  (progn
    (vonfry-system-sets
      (darwin (set-face-attribute 'default nil :font "Hack-11"))
      (gnu/linux  (set-face-attribute 'default nil :font "Hack-8")))
    ;; Chinese Font 配制中文字体
    (defmacro chinese-font (font-name font-size)
      `(dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family ,font-name :size ,font-size))))
    (dolist (charset '(unicode greek))
      (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Symbola" :size 11)
                      nil
                      'append))
    (vonfry-system-sets (darwin (chinese-font "Hei" 10)))))

(package! info)

(custom-set-variables
  '(tool-bar-mode nil)
  '(menu-bar-mode nil)

  '(use-file-dialog nil)
  '(use-dialog-box nil)
  '(inhibit-startup-screen t)
  '(inhibit-startup-echo-area-message t)

  '(display-time-mode t)
  '(display-time-24hr-format t))

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(add-hook 'term-mode-hook
  (lambda ()
    (setq line-spacing 0)))

(defgroup vonfry-ui nil
  "vonfry's emacs ui custom group")

(provide 'core-ui)
