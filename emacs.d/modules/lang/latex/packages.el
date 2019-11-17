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
  (nmap :keymaps '(LaTeX-mode-map tex-mode-map)
        :prefix +nmap-lang-prefix
        "\\" 'TeX-insert-macro
        "-"  'TeX-recenter-output-buffer
        "%"  'TeX-comment-or-uncomment-paragraph
        ";"  'TeX-comment-or-uncomment-region
        "a"  'TeX-command-run-all
        "b"  'latex/build
        "k"  'TeX-kill-job
        "l"  'TeX-recenter-output-buffer
        "m"  'TeX-insert-macro
        "v"  'TeX-view
        "d"  'TeX-doc
        "b"  'latex/font-bold
        "tc" 'latex/font-code
        "te" 'latex/font-emphasis
        "fi" 'latex/font-italic
        "r"  'latex/font-clear
        "o"  'latex/font-oblique
        "fc" 'latex/font-small-caps
        "ff" 'latex/font-sans-serif
        "fr" 'latex/font-serif
        "*"  'LaTeX-mark-section
        "."  'LaTeX-mark-environment
        "c"  'LaTeX-close-environment
        "e"  'LaTeX-environment
        "ii" 'LaTeX-insert-item
        "s"  'LaTeX-section
        "fe" 'LaTeX-fill-environment
        "fp" 'LaTeX-fill-paragraph
        "fr" 'LaTeX-fill-region
        "fs" 'LaTeX-fill-section
        "pb" 'preview-buffer
        "pc" 'preview-clearout
        "pd" 'preview-document
        "pe" 'preview-environment
        "pf" 'preview-cache-preamble
        "pp" 'preview-at-point
        "pr" 'preview-region
        "ps" 'preview-section
        "B"  'latex/font-medium
        "r"  'latex/font-clear
        "fa" 'latex/font-calligraphic
        "fn" 'latex/font-normal
        "fu" 'latex/font-upright
        "z=" 'TeX-fold-math
        "zb" 'TeX-fold-buffer
        "ze" 'TeX-fold-env
        "zm" 'TeX-fold-macro
        "zr" 'TeX-fold-region))

(package! company-math
 :after company
 :config
 (add-to-list 'company-backends 'company-math-symbols-unicode))


(package! company-auctex
  :after company latex yasnippet
  :hook
  ((TeX-mode LaTeX-mode) . company-auctex-init))
