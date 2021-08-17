{ runCommand, fortune, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "ruanyf";
    repo = "fortunes";
    rev = "000fb01261e4d119e4e988ce82f49fb8b139fe3c";
    sha256 = "01x3fjbjsp52c3zwf7p94x2zwj4sxmcrj3vk4rmp8hq7f2z7qviv";
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
