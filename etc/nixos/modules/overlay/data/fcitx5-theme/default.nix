{
  runCommand,
  fortune,
  sources,
}:

let
  src = sources.fcitx5-nord.src;
in
{
  nord = runCommand "nord" { } ''
    mkdir -p $out/share/fcitx5/themes/
    for f in ${src}/Nord-*; do
        cp -r $f $out/share/fcitx5/themes/
    done
  '';
}
