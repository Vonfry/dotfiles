{ ruby }:

ruby.withPackages (p: with p; [
  pry
  pry-byebug
  byebug
  pry-doc
])
