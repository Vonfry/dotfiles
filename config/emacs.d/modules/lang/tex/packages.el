;;; latex packages -*- lexical-binding: t -*-
;;

(package! latex
  :ensure auctex
  :after company
  :custom
  (TeX-master nil)
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-syntactic-comment t)
  (LaTeX-fill-break-at-separators nil)
  (reftex-plug-into-AUCTeX '(nil nil t t t))
  (TeX-command-default "latexmk")
  (TeX-command "latexmk")
  (TeX-auto-untabify t)
  (TeX-engine 'xetex)
  (TeX-save-query nil)
  (TeX-auto-local "latex.out")
  (TeX-auto-private (expand-file-name "tex/" vonfry-cache-dir))
  (TeX-region (expand-file-name "_region_" TeX-auto-private))
  (TeX-view-program-selection (vonfry-system-sets
                               (gnu/linux '((output-pdf "zathura")
                                            (output-dvi "xdvi")
                                            (output-html "xdg-open")))
                                (darwin    '((output-pdf "open")
                                             (output-dvi "open")
                                             (output-html "open")))))
  ;; Synctex support
  ;; Don't insert line-break at inline math
  (TeX-show-compilation t) ; display compilation windows
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-method 'synctex)
  :hook
  ((TeX-mode . font-lock-mode)
   (TeX-mode . LaTeX-mode)
   (LaTeX-mode . LaTeX-math-mode)
   (TeX-mode . TeX-source-correlate-mode)
   (TeX-mode . TeX-PDF-mode)
   (TeX-mode . TeX-fold-mode)
   (TeX-after-compilation-finished-functions . TeX-revert-document-buffer)
   (TeX-mode  .
     (lambda()
       (custom-set! compile-command "latexmk")
       (require 'preview)
       (require 'tex-site)
       ;; use pdfview with auctex
       ;; have the buffer refresh after compilation
       (turn-on-reftex)
       (define-key TeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
       (imenu-add-menubar-index))))
  :general
  (+mmap-tex-def
    "?"   'TeX-doc
    "RET" 'preview-at-point
    "r"   'compile
    "R"   'TeX-command-run-all)
  (+mmap-mode-tex-def
    "\\"  'TeX-insert-macro
    "-"   'TeX-recenter-output-buffer
    "%"   'TeX-comment-or-uncomment-paragraph
    ";"   'TeX-comment-or-uncomment-region
    "b"   'latex/build
    "k"   'TeX-kill-job
    "l"   'TeX-recenter-output-buffer
    "m"   'TeX-insert-macro
    "v"   'TeX-view
    "t"   '(nil :which-key "font")
    "b"   'latex/font-bold
    "t c" 'latex/font-code
    "t e" 'latex/font-emphasis
    "t i" 'latex/font-italic
    "t u" 'latex/font-small-caps
    "t f" 'latex/font-sans-serif
    "t r" 'latex/font-serif
    "r"   'latex/font-clear
    "o"   'latex/font-oblique
    "B"   'latex/font-medium
    "r"   'latex/font-clear
    "t a" 'latex/font-calligraphic
    "t n" 'latex/font-normal
    "t U" 'latex/font-upright
    "*"   'LaTeX-mark-section
    "."   'LaTeX-mark-environment
    "c"   'LaTeX-close-environment
    "e"   'LaTeX-environment
    "i"   'LaTeX-insert-item
    "s"   'LaTeX-section
    "f"   '(nil :which-key "fill")
    "f e" 'LaTeX-fill-environment
    "f p" 'LaTeX-fill-paragraph
    "f r" 'LaTeX-fill-region
    "f s" 'LaTeX-fill-section
    "p"   '(nil :which-key "preview")
    "p b" 'preview-buffer
    "p c" 'preview-clearout
    "p d" 'preview-document
    "p e" 'preview-environment
    "p f" 'preview-cache-preamble
    "p r" 'preview-region
    "p s" 'preview-section
    "z"   '(nil :which-key "fold")
    "z =" 'TeX-fold-math
    "z b" 'TeX-fold-buffer
    "z e" 'TeX-fold-env
    "z m" 'TeX-fold-macro
    "z r" 'TeX-fold-region))

(package! auctex-latexmk
  :after latex
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :config
  (auctex-latexmk-setup))

(package! company-math
 :after company
 :config
 (add-to-list 'company-backends 'company-math-symbols-unicode))

(package! ivy-bibtex
  :after ivy
  :custom
  (bibtex-completion-bibliography '("./refs/refs.bib"))
  (bibtex-completion-library-path '("./refs"))
  :general
  (+mmap-mode-tex-def
    "[" 'ivy-bibtex))

(package! company-auctex
  :after (company latex yasnippet)
  :hook
  (TeX-mode . company-auctex-init))

(package! auctex-latexmk
  :after latex
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :hook
  (LaTeX-mode . (lambda () (setq TeX-command-default "LatexMk")))
  :config
  (auctex-latexmk-setup))
