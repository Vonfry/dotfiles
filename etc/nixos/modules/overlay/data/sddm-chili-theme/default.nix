{ stdenvNoCC, fetchFromGitHub, lib }: # qtbase qtquickcontrols qtgraphicaleffects

stdenvNoCC.mkDerivation rec {
  pname = "chili";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-chili";
    rev = version;
    sha256 = "036fxsa7m8ymmp3p40z671z163y6fcsa9a641lrxdrw225ssq5f3";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/chili
    cp -r * $out/share/sddm/themes/chili
  '';

  meta = with lib; {
    license = licenses.gpl3;
    maintainers = with maintainers; [ mschneider ];
    homepage = https://github.com/MarianArlt/sddm-chili;
    description = "The chili login theme for SDDM";
    longDescription = ''
      Chili is hot, just like a real chili! Spice up the login experience for your users, your family and yourself. Chili reduces all the clutter and leaves you with a clean, easy to use, login interface with a modern yet classy touch.
    '';
  };
}