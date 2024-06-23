# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  background-image = {
    pname = "background-image";
    version = "2024-06-23";
    src = fetchurl {
      url = "https://wiki.haskell.org/wikistatic/haskellwiki_logo.png";
      sha256 = "sha256-NVUPqd/3lxzRPrTfBCBXgxrXR3blEJC/XiJ1nAEcaPQ=";
    };
  };
  fcitx5-nord = {
    pname = "fcitx5-nord";
    version = "bdaa8fb723b8d0b22f237c9a60195c5f9c9d74d1";
    src = fetchFromGitHub {
      owner = "tonyfettes";
      repo = "fcitx5-nord";
      rev = "bdaa8fb723b8d0b22f237c9a60195c5f9c9d74d1";
      fetchSubmodules = false;
      sha256 = "sha256-qVo/0ivZ5gfUP17G29CAW0MrRFUO0KN1ADl1I/rvchE=";
    };
    date = "2021-07-27";
  };
  fortune-chinese = {
    pname = "fortune-chinese";
    version = "000fb01261e4d119e4e988ce82f49fb8b139fe3c";
    src = fetchFromGitHub {
      owner = "ruanyf";
      repo = "fortunes";
      rev = "000fb01261e4d119e4e988ce82f49fb8b139fe3c";
      fetchSubmodules = false;
      sha256 = "sha256-O258vnAHQ3RrJnMPmVntmkj+RSfpHsf/YKJcLZd0owc=";
    };
    date = "2021-08-13";
  };
  rime-cangjie = {
    pname = "rime-cangjie";
    version = "0ac8452eeb4abbcd8dd1f9e7314012310743285f";
    src = fetchFromGitHub {
      owner = "rime";
      repo = "rime-cangjie";
      rev = "0ac8452eeb4abbcd8dd1f9e7314012310743285f";
      fetchSubmodules = false;
      sha256 = "sha256-v8n3+73l9YbTexpA9C2356quioRwFRVcBY0IncolVoY=";
    };
    date = "2024-03-25";
  };
  rime-japanese = {
    pname = "rime-japanese";
    version = "4c1e65135459175136f380e90ba52acb40fdfb2d";
    src = fetchFromGitHub {
      owner = "gkovacs";
      repo = "rime-japanese";
      rev = "4c1e65135459175136f380e90ba52acb40fdfb2d";
      fetchSubmodules = false;
      sha256 = "sha256-/mIIyCu8V95ArKo/vIS3qAiD8InUmk8fAF/wejxRxGw=";
    };
    date = "2023-08-02";
  };
  rime-prelude = {
    pname = "rime-prelude";
    version = "3803f09458072e03b9ed396692ce7e1d35c88c95";
    src = fetchFromGitHub {
      owner = "rime";
      repo = "rime-prelude";
      rev = "3803f09458072e03b9ed396692ce7e1d35c88c95";
      fetchSubmodules = false;
      sha256 = "sha256-qLxkijfB/btd2yhUMbxmoNx6fKxpKYHBZoE7YEUKIu4=";
    };
    date = "2024-05-19";
  };
  rime-wubi86-jidian = {
    pname = "rime-wubi86-jidian";
    version = "3b10be75b5ce049c791159e8145897cda9b12b47";
    src = fetchFromGitHub {
      owner = "KyleBing";
      repo = "rime-wubi86-jidian";
      rev = "3b10be75b5ce049c791159e8145897cda9b12b47";
      fetchSubmodules = false;
      sha256 = "sha256-ZbXVE0/BKR3x6QeDVPthI12yGb38OZ/3eoEJN18P5oY=";
    };
    date = "2024-06-14";
  };
  vonfry-icon = {
    pname = "vonfry-icon";
    version = "2024-06-23";
    src = fetchurl {
      url = "https://vonfry.name/images/default/logo-white.png";
      sha256 = "sha256-57Vf7OS5H6va5M5Tmx87FmpSZtIlqldeiBkwcbrrEm0=";
    };
  };
}
