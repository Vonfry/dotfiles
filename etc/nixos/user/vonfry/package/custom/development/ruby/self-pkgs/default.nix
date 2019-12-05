{ bundlerApp }:

bundlerApp {
  pname = "pry";
  exes = [
    "pry"
    "org-ruby"
    "rougify"
    "licensee"
    "nokogiri"
    "gitlab"
  ];
  gemdir = ./.;
}

