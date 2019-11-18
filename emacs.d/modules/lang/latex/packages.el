;;; latex packages -*- lexical-binding: t -*-
;;

(package! latex
  :straight auctex
  :after company
  :config
  :custom
  (reftex-plug-into-AUCTeX t)
  (latex-command "tectonic")
  (tex-command "tectonic")
  (TeX-auto-untabify t)
  (TeX-engine 'xetex)
  (TeX-master nil)
  (TeX-auto-save t)
  (TeX-save-query nil)
  (TeX-parse-self t)
  (TeX-auto-private (expand-file-name "tex/" vonfry-cache-dir))
  (TeX-PDF-mode t)
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  (TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
  (TeX-syntactic-comment t)
  (TeX-source-correlate-start-server nil)
  (TeX-source-correlate-method 'synctex)
  ;; Synctex support
  ;; Don't insert line-break at inline math
  (LaTeX-fill-break-at-separators nil)
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  (TeX-show-compilation t) ; display compilation windows
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-mode t)
  :hook
  (((LaTeX-mode TeX-mode) . LaTeX-math-mode)
  (TeX-after-compilation-finished-functions . TeX-revert-document-buffer)
  ((TeX-mode LaTeX-mode) .
    (lambda()
      (custom-set-variables '(compile-command "tectonic"))
      (require 'preview)
      (require 'tex-site)
      ;; use pdfview with auctex
      ;; have the buffer refresh after compilation
      (turn-on-reftex)
      (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
      (imenu-add-menubar-index))))
  :general
  (+nmap-lang-tex-def
    "\\"  'TeX-insert-macro
    "-"   'TeX-recenter-output-buffer
    "%"   'TeX-comment-or-uncomment-paragraph
    ";"   'TeX-comment-or-uncomment-region
    "a"   'TeX-command-run-all
    "b"   'latex/build
    "k"   'TeX-kill-job
    "l"   'TeX-recenter-output-buffer
    "m"   'TeX-insert-macro
    "v"   'TeX-view
    "d"   'TeX-doc
    "b"   'latex/font-bold
    "t c" 'latex/font-code
    "t e" 'latex/font-emphasis
    "f i" 'latex/font-italic
    "r"   'latex/font-clear
    "o"   'latex/font-oblique
    "f c" 'latex/font-small-caps
    "f f" 'latex/font-sans-serif
    "f r" 'latex/font-serif
    "*"   'LaTeX-mark-section
    "."   'LaTeX-mark-environment
    "c"   'LaTeX-close-environment
    "e"   'LaTeX-environment
    "i i" 'LaTeX-insert-item
    "s"   'LaTeX-section
    "f e" 'LaTeX-fill-environment
    "f p" 'LaTeX-fill-paragraph
    "f r" 'LaTeX-fill-region
    "f s" 'LaTeX-fill-section
    "p b" 'preview-buffer
    "p c" 'preview-clearout
    "p d" 'preview-document
    "p e" 'preview-environment
    "p f" 'preview-cache-preamble
    "p p" 'preview-at-point
    "p r" 'preview-region
    "p s" 'preview-section
    "B"   'latex/font-medium
    "r"   'latex/font-clear
    "f a" 'latex/font-calligraphic
    "f n" 'latex/font-normal
    "f u" 'latex/font-upright
    "z =" 'TeX-fold-math
    "z b" 'TeX-fold-buffer
    "z e" 'TeX-fold-env
    "z m" 'TeX-fold-macro
    "z r" 'TeX-fold-region))

(package! company-math
 :after company
 :config
 (add-to-list 'company-backends 'company-math-symbols-unicode))


(package! company-auctex
  :after company latex yasnippet
  :hook
  ((TeX-mode LaTeX-mode) . company-auctex-init))
