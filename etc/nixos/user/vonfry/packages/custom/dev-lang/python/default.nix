{ python }:

python.withPackages (pythonPackages: with pythonPackages; [ 
  gpgme # dropbox required
  scipy numpy pandas matplotlib sympy ipython 
  ])
