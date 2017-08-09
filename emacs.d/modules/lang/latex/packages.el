;;; latex packages -*- lexical-binding: t -*-

(vonfry|use-package! auctex
  ; This packages have some problem with package-build.
  :defer t
  :ensure t)

;; (vonfry|packages!
;;   (auctex :fetcher github :repo "emacsmirror/auctex") :upgrade nil)


(vonfry|packages!
  auctex-latexmk
  company-auctex
  company-math)
