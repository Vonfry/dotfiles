(in-package #:nyxt-user)

(define-configuration browser
    ((theme
      (make-instance 'theme:theme
                     ; take from daiysui dracula theme.
                     ; constrast color is mixed with black or white.
                     :monospace-font-family "monospace"
                     :font-family "sans serif"
                     :background-color  "#282a36"
                     :background-color+ "#3e3f4a"
                     :background-color- "#686a72"
                     :on-background-color  nil
                     :primary-color "#ff79c6"
                     :primary-color+ "#e66db2"
                     :primary-color- "#b2648b"
                     :on-primary-color "#16050e"
                     :secondary-color "#bd93f9"
                     :secondary-color+ "#aa84e0"
                     :secondary-color- "#8476ae"
                     :on-secondary-color "#16050e"
                     :action-color "#ffb86c"
                     :action-color+ "#e6a661"
                     :action-color- "#b2904c"
                     :on-action-color "#16050e"
                     :highlight-color "#8be9fd"
                     :highlight-color+ "#7dd7e4"
                     :highlight-color- "#61b2b1"
                     :on-highlight-color "#16050e"
                     :success-color "#50fa7b"
                     :success-color+ "#48e16f"
                     :success-color- "#38be56"
                     :on-success-color "#16050e"
                     :warning-color "#f1fa8c"
                     :warning-color+ "#d9e17e"
                     :warning-color- "#a9be62"
                     :on-warning-color "#16050e"
                     :codeblock-color "#000000"
                     :codeblock-color+ "#6272a4"
                     :codeblock-color- "#7280ad"
                     :on-codeblock-color nil
                     :text-color "#f8f8f2"
                     :text-color+ "#dfe4da"
                     :text-color- "#aebda9"
                     :contrast-text-color "#6272a4"))))
