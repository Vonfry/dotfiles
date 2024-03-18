{ stdenvNoCC, sources, lib }: # qtbase qtgraphicaleffects roboto
let
in
stdenvNoCC.mkDerivation rec {
  pname = "sddm-slice-theme";
  inherit (sources.sddm-slice) version src;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/slice
    cp -r * $out/share/sddm/themes/slice
  '';

  meta = with lib; {
    license = licenses.cc-by-sa-40;
    maintainers = with maintainers; [ vonfry ];
    homepage = "https://github.com/RadRussianRus/sddm-slice";
    description = "Simple dark SDDM theme with many customization options.";
  };
}
