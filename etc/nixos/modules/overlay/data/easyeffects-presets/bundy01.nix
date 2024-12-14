{
  runCommandNoCC,
  sources,
}:

let
  src = sources.bundy01Easyeffects.src;
in
runCommandNoCC "bundy01-easyeffects-presets" { } ''
  install -D -t $out/share/easyeffects/output/bundy01 ${src}/*.json
''
