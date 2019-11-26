;;; pretty modules -*- lexical-binding: t; -*-
;;

(add-hook 'prog-mode-hook #'+pretty-code-init-pretty-symbols-h)

(add-hook 'window-setup-hook #'+pretty-code-setup-h)

(custom-set-variables
  '(prettify-symbols-unprettify-at-point 'right-edge))
