{
  runCommandNoCC,
  sources,
}:

let
  src = sources.jackhack96Easyeffects.src;
in
runCommandNoCC "bundy01-easyeffects-presets" { } ''
  install -D -t $out/share/easyeffects/output/jackhack96 ${src}/*.json
''
