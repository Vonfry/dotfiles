;;; proof config -*- lexical-binding: t -*-
;;

;; +mmap-lang-proof-def
(vonfry-def-mmap-lang-prefix proof nil
  :keymaps 'coq-mode-map)

;; +mmap-proof-def
(vonfry-def-mmap-leader-prefix proof nil
  :keymaps 'coq-mode-map)

(defcustom +proof-use-special-font nil
  "If not nil, use special font."
  :group 'vonfry-module)

(defface +proof-buffer-local-face
    '((t :family "Symbola" :height 110))
    "proof buffer-local face")

(defcustom +proof-special-font '+proof-buffer-local-face
  "The special face."
  :group 'vonfry-module)

(defcustom +proof-prettify-symbol-alist
  '(("\\/" . #X110084)
    ("/\\" . #X110083)
    ("<>"  . #X110067))
  "a partial copy from `company-coq', which are only used in coq mode"
  :group 'vonfry-module)
