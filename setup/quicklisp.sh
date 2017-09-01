echo_info "** setup clisp"
curl https://beta.quicklisp.org/quicklisp.lisp -o ~/.cache/quicklisp.lisp
if [  ]; then
  echo_info "*** setup quicklisp"
  sbcl --load ~/.cache/quicklisp.lisp --script $script_dir/setup/quicklisp.lisp
else
  echo_warn "!!! ERROR: no lisp"
  exit 1
fi
