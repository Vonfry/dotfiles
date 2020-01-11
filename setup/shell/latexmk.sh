cp $script_dir/latexmkrc ~/.latexmkrc

if [ $(uname) = "Linux" ]; then

cat <<EOF >> ~/.latexmkrc

\$dvi_previewer = 'xdvi -watchfile 1.5';
\$ps_previewer  = 'feh';
\$pdf_previewer = 'zathura';
EOF

elif [ $(uname) = 'Darwin' ]; then

cat <<EOF >> ~/.latexmkrc

\$pdf_previewer = 'open -a Skim';
\$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode';
@generated_exts = (@generated_exts, 'synctex.gz');
EOF

fi
