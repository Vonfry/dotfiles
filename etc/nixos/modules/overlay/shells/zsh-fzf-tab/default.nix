{ stdenv, fetchFromGitHub, fzf, zsh, ncurses }:

stdenv.mkDerivation rec {
  pname = "zsh-fzf-tab";
  version = "2021-04-01";

  src = fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "0c36bdcf6a80ec009280897f07f56969f94d377e";
    sha256 = "0ymp9ky0jlkx9b63jajvpac5g3ll8snkf8q081g0yw42b9hwpiid";
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
