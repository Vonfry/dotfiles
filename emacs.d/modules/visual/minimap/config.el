;;; minimap config -*- lexical-binding: t -*-

(use-package! sublimity
  :config
  (use-package! sublimity-map)
  (use-package! sublimity-scroll)
  (custom-set-variables
    '(sublimity-map-set-delay nil))
  (sublimity-mode 1))

