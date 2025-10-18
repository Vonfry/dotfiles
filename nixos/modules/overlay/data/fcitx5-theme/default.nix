{
  runCommandNoCC,
  sources,
}:

let
  src = sources.fcitx5-dracula.src;
in
{
  dracula = runCommandNoCC "fcitx5-dracula" { } ''
    outbase=$out/share/fcitx5/themes/dracula
    install -D -t $outbase \
        ${src}/theme.conf \
        ${src}/radio.png \
        ${src}/panel.png \
        ${src}/arrow.png \
        ${src}/paneltrans.png
    substituteInPlace $outbase/theme.conf \
        --replace-fail "Image=" "Image=$outbase/"
  '';
}
