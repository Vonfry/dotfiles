;; This file is used to config some frame variables. If you want to modify them,
;; you can use `custom-set-variables' in `custom-file'.

(setq-default
  initial-frame-alist '((width . 160)
                        (height . 72)
                        (horizontal-scroll-bars . nil)
                        (vertical-scroll-bars . nil))
  default-frame-alist initial-frame-alist

  use-file-dialog nil
  use-dialog-box nil

  tool-bar-mode nil
  menu-bar-mode nil
  scroll-bar-mode nil

  frame-title-format '("" invocation-name ": %b")

  x-gtk-use-native-input t)

(startup-redirect-eln-cache
    (expand-file-name "eln/"
                    (expand-file-name "emacs" (xdg-cache-home))))
