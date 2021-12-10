{ stdenv, fetchFromGitHub }:

{
  material-color = fetchFromGitHub {
    owner = "hosxy";
    repo = "Fcitx5-Material-Color";
    rev = "2256feeae48dcc87f19a3cfe98f171862f8fcace";
    sha256 = "0drdypjf1njl7flkb5d581vchwlp4gaqyws3cp0v874wkwh4gllb";
  };

  nord = fetchFromGitHub {
    owner = "tonyfettes" ;
    repo = "fcitx5-nord";
    rev = "bdaa8fb723b8d0b22f237c9a60195c5f9c9d74d1";
    sha256 = "sha256-qVo/0ivZ5gfUP17G29CAW0MrRFUO0KN1ADl1I/rvchE=";
  };
}
