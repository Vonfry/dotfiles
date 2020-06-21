{ ruby }:

ruby.withPackages (p: with p;
  [ pry
    pry-byebug
    pry-doc
    pry-rails
    nokogiri
  ])
