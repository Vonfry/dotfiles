{
  runCommandNoCC,
  sources,
}:

let
  src = sources.easypulse.src;
in
runCommandNoCC "easypulse" { } ''
  install -D -t $out/share/easyeffects/output/easypulse ${src}/output/*.json
''
