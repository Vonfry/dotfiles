((nix-ts-mode . ((eval .
                       (let ((getflake (lambda (s)
                                         (format
                                          "(builtins.getFlake \"path:%s\").%s"
                                          (dir-locals-find-file ".")))))
                         (setq-local
                          eglot-workspace-configuration
                          `(:nixd
                            (:nixpkgs
                             (:expr (format
                                     "import %s { }"
                                     (getflake "inputs.nixpkgs")))
                             :formatting
                             (:command ["nixfmt"])
                             :options
                             (:nixos
                              (:expr
                               (getflake
                                "nixosConfigurations.vonfry.options")))))))))))
