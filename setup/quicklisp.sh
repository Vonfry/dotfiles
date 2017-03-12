echo_sh "** setup quicklisp"
curl https://beta.quicklisp.org/quicklisp.lisp -o ~/.cache/quicklisp.lisp
sbcl --load ~/.cache/quicklisp.lisp --script $script_dir/setup/quicklisp.lisp
