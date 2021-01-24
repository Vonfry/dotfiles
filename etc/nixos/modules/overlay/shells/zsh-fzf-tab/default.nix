{ stdenv, fetchFromGitHub, fzf, zsh, ncurses }:

stdenv.mkDerivation rec {
  pname = "zsh-fzf-tab";
  version = "2021-01-24";

  src = fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "78b4cefb27dc2bef5e4c9ac3bf2bd28413620fcd";
    sha256 = "1f5m7vf7wxzczis2nzvhgqaqnphhp3a0wv8b612m7g4fnvk3lnkn";
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
