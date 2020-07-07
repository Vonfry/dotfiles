;;; pretty modules -*- lexical-binding: t; -*-
;;

(hook! prog-mode +pretty-code-init-pretty-symbols-h)

(hook! window-setup +pretty-code-setup-h)

(custom-set!
  prettify-symbols-unprettify-at-point 'right-edge)
