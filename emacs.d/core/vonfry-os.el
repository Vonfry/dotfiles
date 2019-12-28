;;; core/core-os.el -*- lexical-binding: t -*-
;;
;; This core packages is used to set some variables to make emacs more easily on these os.

(when (fboundp 'toggle-frame-fullscreen)
  (vonfry-system-sets (darwin (global-set-key (kbd "M-C-f") 'toggle-frame-fullscreen))))

(vonfry-system-sets
  (darwin
    (custom-set-variables
      '(mac-command-modifier 'meta)
      '(mac-option-modifier 'super)))
  (gnu/linux
    (custom-set-variables
      '(x-alt-keysym 'meta))))

(provide 'vonfry-os)
