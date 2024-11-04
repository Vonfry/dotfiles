{
  runCommand,
  fortune,
  sources,
}:

let
  inherit (sources.fortune-chinese) src;

in
runCommand "fortune-chinese" { } ''
  mkdir -p $out/share/fortunes
  cp ${src}/data/* $out/share/fortunes
  (
    cd $out/share/fortunes
    rm *.dat
    for f in *; do
      ${fortune}/bin/strfile $f
    done
  )
''
