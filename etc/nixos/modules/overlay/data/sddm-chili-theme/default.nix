{ stdenvNoCC, sources, lib }: # qtbase qtquickcontrols qtgraphicaleffects

stdenvNoCC.mkDerivation rec {
  pname = "chili";
  inherit (sources.sddm-chili) version src;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/chili
    cp -r * $out/share/sddm/themes/chili
  '';

  meta = with lib; {
    license = licenses.gpl3;
    maintainers = with maintainers; [ vonfry ];
    homepage = "https://github.com/MarianArlt/sddm-chili";
    description = "The chili login theme for SDDM";
    longDescription = ''
      Chili is hot, just like a real chili! Spice up the login experience for your users, your family and yourself. Chili reduces all the clutter and leaves you with a clean, easy to use, login interface with a modern yet classy touch.
    '';
  };
}
