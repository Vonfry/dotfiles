if [ $(uname) = "linux" ]; then

cat <<EOF > ~/.latexmkrc

\$dvi_previewer = 'xdvi -watchfile 1.5';
\$ps_previewer  = 'feh';
\$pdf_previewer = 'qpdfviewer';
EOF

elif [ $(uname) = 'darwin' ]; then

cat <<EOF > ~/.latexmkrc

\$pdf_previewer = 'open -a Skim';
\$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode';
@generated_exts = (@generated_exts, 'synctex.gz');
EOF

fi
