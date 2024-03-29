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

  icon-title-format t
  frame-title-format '("" invocation-name ": %b")

  x-gtk-use-native-input t)

(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(require 'vonfry-local)

(when (and (boundp 'native-comp-eln-load-path)
           (fboundp 'startup-redirect-eln-cache))
  (startup-redirect-eln-cache
   (expand-file-name "eln/" vonfry-cache-dir)))
