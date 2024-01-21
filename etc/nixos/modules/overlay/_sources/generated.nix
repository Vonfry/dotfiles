# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  aria-ng = {
    pname = "aria-ng";
    version = "1.3.7";
    src = fetchurl {
      url = "https://github.com/mayswind/AriaNg/releases/download/1.3.7/AriaNg-1.3.7-AllInOne.zip";
      sha256 = "sha256-G+bi1QS19t4PBHqs2ksOVNwcZTo8tenFjZ3tYnDPfdY=";
    };
  };
  background-image = {
    pname = "background-image";
    version = "2024-01-21";
    src = fetchurl {
      url = "https://wiki.haskell.org/wikistatic/haskellwiki_logo.png";
      sha256 = "sha256-NVUPqd/3lxzRPrTfBCBXgxrXR3blEJC/XiJ1nAEcaPQ=";
    };
  };
  fcitx5-material-color = {
    pname = "fcitx5-material-color";
    version = "2256feeae48dcc87f19a3cfe98f171862f8fcace";
    src = fetchFromGitHub {
      owner = "hosxy";
      repo = "fcitx5-material-color";
      rev = "2256feeae48dcc87f19a3cfe98f171862f8fcace";
      fetchSubmodules = false;
      sha256 = "sha256-i9JHIJ+cHLTBZUNzj9Ujl3LIdkCllTWpO1Ta4OT1LTc=";
    };
    date = "2021-02-21";
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
    version = "75b10325bf4c590a3ffef7039a6f052a729edc55";
    src = fetchFromGitHub {
      owner = "rime";
      repo = "rime-cangjie";
      rev = "75b10325bf4c590a3ffef7039a6f052a729edc55";
      fetchSubmodules = false;
      sha256 = "sha256-5Ku2dO1qULadIocOq4dYHx+p2HhvqCtz7h//wos19RY=";
    };
    date = "2023-12-11";
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
    version = "dd84abecc33f0b05469f1d744e32d2b60b3529e3";
    src = fetchFromGitHub {
      owner = "rime";
      repo = "rime-prelude";
      rev = "dd84abecc33f0b05469f1d744e32d2b60b3529e3";
      fetchSubmodules = false;
      sha256 = "sha256-r3jx/iCUOxBFLYhmHEuSFxzmHg8l6vnuONmsjbtBlpM=";
    };
    date = "2022-04-10";
  };
  rime-wubi86-jidian = {
    pname = "rime-wubi86-jidian";
    version = "e436e16266a3c6c9c4f0da6f41522496061924e7";
    src = fetchFromGitHub {
      owner = "KyleBing";
      repo = "rime-wubi86-jidian";
      rev = "e436e16266a3c6c9c4f0da6f41522496061924e7";
      fetchSubmodules = false;
      sha256 = "sha256-JM0DKa3zDycZlDA2iXt1HgLrZKQdyaR8Wg0d+xL3uzo=";
    };
    date = "2024-01-09";
  };
  sddm-chili = {
    pname = "sddm-chili";
    version = "0.1.5";
    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-chili";
      rev = "0.1.5";
      fetchSubmodules = false;
      sha256 = "sha256-wxWsdRGC59YzDcSopDRzxg8TfjjmA3LHrdWjepTuzgw=";
    };
  };
  sddm-slice = {
    pname = "sddm-slice";
    version = "1.5.1";
    src = fetchFromGitHub {
      owner = "RadRussianRus";
      repo = "sddm-slice";
      rev = "1.5.1";
      fetchSubmodules = false;
      sha256 = "sha256-1AxRM2kHOzqjogYjFXqM2Zm8G3aUiRsdPDCYTxxQTyw=";
    };
  };
  vonfry-icon = {
    pname = "vonfry-icon";
    version = "2024-01-21";
    src = fetchurl {
      url = "https://vonfry.name/images/default/logo-white.png";
      sha256 = "sha256-57Vf7OS5H6va5M5Tmx87FmpSZtIlqldeiBkwcbrrEm0=";
    };
  };
}
