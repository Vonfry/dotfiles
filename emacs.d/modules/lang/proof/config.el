;;; proof config -*- lexical-binding: t -*-
;;

;; +mmap-mode-proof-def
(vonfry-def-mmap-mode-prefix proof nil
  :keymaps 'coq-mode-map)

;; +mmap-proof-def
(vonfry-def-mmap-leader-prefix proof nil
  :keymaps 'coq-mode-map)

(defcustom +proof-use-special-font nil
  "If not nil, use special font."
  :group 'vonfry-modules)

(defface +proof-buffer-local-face
    '((t :family "Symbola" :height 110))
    "proof buffer-local face")

(defcustom +proof-special-font '+proof-buffer-local-face
  "The special face."
  :group 'vonfry-modules)

(defcustom +proof-prettify-symbol-alist
  '(("\\/" . #Xe13c)
    ("/\\" . #Xe13b)
    ("<>"  . #Xe11f))
  "a partial copy from `company-coq', which are only used in coq mode"
  :type '(repeat (alist :key-type string :value-type character))
  :group 'vonfry-modules)
