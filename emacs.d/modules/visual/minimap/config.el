;;; minimap config -*- lexical-binding: t -*-

(use-package! sublimity
  :config
  (use-package! sublimity-map)
  (custom-set-variables
    '(sublimity-map-set-delay nil))
  (sublimity-mode 1))

