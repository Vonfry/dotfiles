;;; latex config -*- lexical-binding: t -*-

(load "auctex") ;; this package hasn't called (provide).

(vonfry|use-package! latex
  :after company
  :config
  (require 'preview)
  (require 'tex-site)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'TeX-mode-hook 'LaTeX-math-mode)
  (dolist (mode-hook '(tex-mode-hook latex-mode-hook))
    (add-hook mode-hook
      (lambda()
        (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
        (setq TeX-auto-untabify t     ; remove all tabs before saving
              TeX-engine 'xetex       ; use xelatex default
              TeX-auto-save t
              TeX-parse-self t
              TeX-syntactic-comment t
              ;; Synctex support
              TeX-source-correlate-start-server nil
              ;; Don't insert line-break at inline math
              LaTeX-fill-break-at-separators nil
              auctex-latexmk-inherit-TeX-PDF-mode t
              TeX-show-compilation t) ; display compilation windows
        (setq TeX-save-query nil)
        (imenu-add-menubar-index)
        (nmap :keymaps 'local
              :prefix +lang-nmap-prefix
              "\\"  'TeX-insert-macro                            ;; C-c C-m
              "-"   'TeX-recenter-output-buffer                  ;; C-c C-l
              "%"   'TeX-comment-or-uncomment-paragraph          ;; C-c %
              ";"   'TeX-comment-or-uncomment-region             ;; C-c ; or C-c :
              ;; TeX-command-run-all runs compile and open the viewer
              "a"   'TeX-command-run-all                         ;; C-c C-a
              "b"   'latex/build
              "k"   'TeX-kill-job                                ;; C-c C-k
              "l"   'TeX-recenter-output-buffer                  ;; C-c C-l
              "m"   'TeX-insert-macro                            ;; C-c C-m
              "v"   'TeX-view                                    ;; C-c C-v
              ;; TeX-doc is a very slow function
              "d"   'TeX-doc
              "b"   'latex/font-bold
              "tc"  'latex/font-code
              "te"  'latex/font-emphasis
              "i"   'latex/font-italic
              "r"   'latex/font-clear
              "o"   'latex/font-oblique
              "fc"  'latex/font-small-caps
              "ff"  'latex/font-sans-serif
              "fr"  'latex/font-serif
              "*"   'LaTeX-mark-section      ;; C-c *
              "."   'LaTeX-mark-environment  ;; C-c .
              "c"   'LaTeX-close-environment ;; C-c ]
              "e"   'LaTeX-environment       ;; C-c C-e
              "ii"  'LaTeX-insert-item       ;; C-c C-j
              "s"   'LaTeX-section           ;; C-c C-s
              "fe"  'LaTeX-fill-environment  ;; C-c C-q C-e
              "fp"  'LaTeX-fill-paragraph    ;; C-c C-q C-p
              "fr"  'LaTeX-fill-region       ;; C-c C-q C-r
              "fs"  'LaTeX-fill-section      ;; C-c C-q C-s
              "pb"  'preview-buffer
              "pc"  'preview-clearout
              "pd"  'preview-document
              "pe"  'preview-environment
              "pf"  'preview-cache-preamble
              "pp"  'preview-at-point
              "pr"  'preview-region
              "ps"  'preview-section
              "B"   'latex/font-medium
              "r"   'latex/font-clear
              "fa"  'latex/font-calligraphic
              "fn"  'latex/font-normal
              "fu"  'latex/font-upright
              "mh"  "help"
              "mx"  "text/fonts"
              "mz"  "fold")
            (when latex-enable-folding
              (nmap :keymaps 'local
                    :prefix +lang-nmap-prefix
                    "z=" 'TeX-fold-math
                    "zb" 'TeX-fold-buffer
                    "ze" 'TeX-fold-env
                    "zm" 'TeX-fold-macro
                    "zr" 'TeX-fold-region))))))

(vonfry|use-package! auctex-latexmk
  :after latex
  :config
  (add-hook 'LaTeX-mode-hook 'auctex-latexmk-setup)
  (add-hook 'TeX-mode-hook 'auctex-latexmk-setup))

(vonfry|use-package! company-math
 :after company
 :config
 (add-to-list (make-local-variable 'company-backends) 'company-math-symbols-unicode))


(vonfry|use-package! company-auctex
  :after company latex
  :config
  (add-hook 'TeX-mode-hook 'company-auctex-init)
  (add-hook 'LaTeX-mode-hook 'company-auctex-init))
