{ runCommand }:

src:

runCommand "rime-${src.name}" {} ''
  mkdir -p $out/share/rime-plugins
  ln -s ${src}/*.yaml $out/share/rime-plugins
''
