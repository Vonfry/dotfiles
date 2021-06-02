{ stdenv, fetchFromGitHub }:

{
  material-color = fetchFromGitHub {
    owner = "hosxy";
    repo = "Fcitx5-Material-Color";
    rev = "2256feeae48dcc87f19a3cfe98f171862f8fcace";
    sha256 = "0drdypjf1njl7flkb5d581vchwlp4gaqyws3cp0v874wkwh4gllb";
  };
}
