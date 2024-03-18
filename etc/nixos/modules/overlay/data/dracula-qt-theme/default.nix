{ stdenvNoCC, sources, lib }:

stdenvNoCC.mkDerivation rec {
  pname = "dracula-qt-theme";

  inherit (sources.dracula-qt5-theme) src version;

  installPhase = ''
    install -D ${src}/Dracula.conf $out/share/qt5ct/colors/Dracula.conf
    install -D ${src}/Dracula.conf $out/share/qt6ct/colors/Dracula.conf
  '';

  meta = with lib; {
    license = licenses.mit;
    maintainers = with maintainers; [ vonfry ];
    homepage = "https://github.com/dracula/qt5";
    description = "Dark theme for qt5";
  };
}
