{ stdenvNoCC, fetchFromGitHub, lib }: # qtbase qtgraphicaleffects roboto
let
in
stdenvNoCC.mkDerivation rec {
  pname = "sddm-slice-theme";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "RadRussianRus";
    repo = "sddm-slice";
    rev = version;
    sha256 = "0b2ga0f4z61h7hfip2clfqdvr6friix1a8q6laiklfq7d4rm236l";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/slice
    cp -r * $out/share/sddm/themes/slice
  '';

  meta = with lib; {
    license = licenses.cc-by-sa-40;
    maintainers = with maintainers; [ vonfry ];
    homepage = https://github.com/RadRussianRus/sddm-slice;
    description = "Simple dark SDDM theme with many customization options.";
  };
}
