{ stdenv, fetchFromGitHub, fzf, zsh, ncurses }:

stdenv.mkDerivation rec {
  pname = "zsh-fzf-tab";
  version = "2021-02-14";

  src = fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "8cebb8f01ca57076c3c7cd66365270d989bcaa89";
    sha256 = "119m84g2c4z9xdr22j401p09n3cpiyj61dw5m7xkm6309nd7zz0a";
  };

  buildInputs = [ ncurses zsh fzf ];

  postConfigure = ''
    pushd modules
    ./configure --disable-gdbm --without-tcsetpgrp
    popd
  '';

  postBuild = ''
    pushd modules
    make -j
    popd
  '';

  installPhase = ''
     mkdir ${placeholder "out"}
     cp -r lib ${placeholder "out"}/lib
     install -D fzf-tab.zsh ${placeholder "out"}/fzf-tab.zsh
     install -D fzf-tab.plugin.zsh ${placeholder "out"}/fzf-tab.plugin.zsh
     install -D modules/Src/aloxaf/fzftab.so ${placeholder "out"}/modules/Src/aloxaf/fzftab.so
  '';
}
