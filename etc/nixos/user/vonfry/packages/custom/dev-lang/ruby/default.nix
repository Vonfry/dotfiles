{ bundlerApp }:

bundlerApp {
  pname = "pry";
  exes = [
    "pry" 
    "rufo" 
    "org-ruby" 
    "rougify" 
    "licensee" 
    "nokogiri" 
    "gitlab" 
  ];
  gemdir = ./.;
}

