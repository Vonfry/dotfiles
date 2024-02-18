(in-package #:nyxt-user)

(define-configuration browser
    ((theme
      (make-instance 'theme:theme
                     :monospace-font-family "monospace"
                     :font-family "sans serif"
                     :background-color+ "#6272a4"
                     :background-color  "#282a36"
                     :background-color- "#44475a"
                     :on-background-color- "#f8f8f2"
                     :on-background-color  "#f8f8f2"
                     :on-background-color+ "#f8f8f2"
                     :action-color "#f1fa8c"
                     :action-color+ "#f1fa8c"
                     :action-color- "#f1fa8c"
                     :on-action-color "#282a36"
                     :on-action-color+ "#282a36"
                     :on-action-color- "#282a36"
                     :primary-color "#bd93f9"
                     :on-primary-color "#282a36"
                     :secondary-color "#ff79c6"
                     :on-secondary-color "#282a36"))))
