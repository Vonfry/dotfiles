# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  aria-ng = {
    pname = "aria-ng";
    version = "1.2.3";
    src = fetchurl {
      url = "https://github.com/mayswind/AriaNg/releases/download/1.2.3/AriaNg-1.2.3-AllInOne.zip";
      sha256 = "sha256-GGIXVQDhWzsU7/jbTrovveTpSKHSqInvFDm/p9k87cM=";
    };
  };
  background-image = {
    pname = "background-image";
    version = "20220515";
    src = fetchurl {
      url = "https://wiki.haskell.org/wikistatic/haskellwiki_logo.png";
      sha256 = "sha256-NVUPqd/3lxzRPrTfBCBXgxrXR3blEJC/XiJ1nAEcaPQ=";
    };
  };
  fcitx5-material-color = {
    pname = "fcitx5-material-color";
    version = "2256feeae48dcc87f19a3cfe98f171862f8fcace";
    src = fetchFromGitHub ({
      owner = "hosxy";
      repo = "fcitx5-material-color";
      rev = "2256feeae48dcc87f19a3cfe98f171862f8fcace";
      fetchSubmodules = false;
      sha256 = "sha256-i9JHIJ+cHLTBZUNzj9Ujl3LIdkCllTWpO1Ta4OT1LTc=";
    });
  };
  fcitx5-nord = {
    pname = "fcitx5-nord";
    version = "bdaa8fb723b8d0b22f237c9a60195c5f9c9d74d1";
    src = fetchFromGitHub ({
      owner = "tonyfettes";
      repo = "fcitx5-nord";
      rev = "bdaa8fb723b8d0b22f237c9a60195c5f9c9d74d1";
      fetchSubmodules = false;
      sha256 = "sha256-qVo/0ivZ5gfUP17G29CAW0MrRFUO0KN1ADl1I/rvchE=";
    });
  };
  fortune-chinese = {
    pname = "fortune-chinese";
    version = "000fb01261e4d119e4e988ce82f49fb8b139fe3c";
    src = fetchFromGitHub ({
      owner = "ruanyf";
      repo = "fortunes";
      rev = "000fb01261e4d119e4e988ce82f49fb8b139fe3c";
      fetchSubmodules = false;
      sha256 = "sha256-O258vnAHQ3RrJnMPmVntmkj+RSfpHsf/YKJcLZd0owc=";
    });
  };
  rime-cangjie = {
    pname = "rime-cangjie";
    version = "8dfad9e537f18821b71ba28773315d9c670ae245";
    src = fetchFromGitHub ({
      owner = "rime";
      repo = "rime-cangjie";
      rev = "8dfad9e537f18821b71ba28773315d9c670ae245";
      fetchSubmodules = false;
      sha256 = "fmWGgYqWndCpDUV6nzx0zjkcf5AcVeDIYwp0023iMwk=";
    });
  };
  rime-japanese = {
    pname = "rime-japanese";
    version = "189f5e57198ff392518a901ab748beb0b44254f2";
    src = fetchFromGitHub ({
      owner = "gkovacs";
      repo = "rime-japanese";
      rev = "189f5e57198ff392518a901ab748beb0b44254f2";
      fetchSubmodules = false;
      sha256 = "sha256-YY5c8slZWpIuCazz6Ltbt813wYxR38xgGY/aqY0DozM=";
    });
  };
  rime-prelude = {
    pname = "rime-prelude";
    version = "dd84abecc33f0b05469f1d744e32d2b60b3529e3";
    src = fetchFromGitHub ({
      owner = "rime";
      repo = "rime-prelude";
      rev = "dd84abecc33f0b05469f1d744e32d2b60b3529e3";
      fetchSubmodules = false;
      sha256 = "sha256-r3jx/iCUOxBFLYhmHEuSFxzmHg8l6vnuONmsjbtBlpM=";
    });
  };
  rime-wubi86-jidian = {
    pname = "rime-wubi86-jidian";
    version = "e97c079010eb9e4befb3c4edb8ccf73a26b54c60";
    src = fetchFromGitHub ({
      owner = "KyleBing";
      repo = "rime-wubi86-jidian";
      rev = "e97c079010eb9e4befb3c4edb8ccf73a26b54c60";
      fetchSubmodules = false;
      sha256 = "sha256-3hbtL0TCLeYySQFpACITgPjocdkZoyIORpAHkgtIvVk=";
    });
  };
  sddm-chili = {
    pname = "sddm-chili";
    version = "0.1.5";
    src = fetchFromGitHub ({
      owner = "MarianArlt";
      repo = "sddm-chili";
      rev = "0.1.5";
      fetchSubmodules = false;
      sha256 = "sha256-wxWsdRGC59YzDcSopDRzxg8TfjjmA3LHrdWjepTuzgw=";
    });
  };
  sddm-slice = {
    pname = "sddm-slice";
    version = "1.5.1";
    src = fetchFromGitHub ({
      owner = "RadRussianRus";
      repo = "sddm-slice";
      rev = "1.5.1";
      fetchSubmodules = false;
      sha256 = "sha256-1AxRM2kHOzqjogYjFXqM2Zm8G3aUiRsdPDCYTxxQTyw=";
    });
  };
  vonfry-icon = {
    pname = "vonfry-icon";
    version = "20220515";
    src = fetchurl {
      url = "https://vonfry.name/images/default/logo-white.png";
      sha256 = "0v8jxfx72c0ri1g5gai5s9k54shn7cgrnlyfwkdan7xrwkn5zdg7";
    };
  };
}
