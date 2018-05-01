;;; minimap config -*- lexical-binding: t -*-

(use-package! sublimity
  :config
  (use-package! sublimity-map)
  (sublimity-mode 1)
  :custom
  (sublimity-map-set-delay nil))

