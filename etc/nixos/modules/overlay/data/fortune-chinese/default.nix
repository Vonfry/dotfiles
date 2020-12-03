{ runCommand, fortune, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "ruanyf";
    repo = "fortunes";
    rev = "b3e61a751e724891f4723414144c74ef7dd413f1";
    sha256 = "0x79j7gl2r21rw7mdd7kkc7zs5w2qmw4lj95xzciggcgq3pq4k2s";
  };

in runCommand "fortune-chinese" {} ''
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
