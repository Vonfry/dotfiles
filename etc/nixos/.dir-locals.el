((nix-ts-mode . ((eval .
                       (let ((getflake (lambda (s)
                                         (format
                                          "(builtins.getFlake \"path:%s\").%s"
                                          (dir-locals-find-file ".")
                                          s))))
                         (setq-local
                          eglot-workspace-configuration
                          `(:nixd
                            (:nixpkgs
                             (:expr ,(format
                                      "import %s { }"
                                      (funcall getflake "inputs.nixpkgs")))
                             :formatting
                             (:command ["nixfmt"])
                             :options
                             (:nixos
                              (:expr
                               ,(funcall
                                 getflake
                                 "nixosConfigurations.vonfry.options")))))))))))
