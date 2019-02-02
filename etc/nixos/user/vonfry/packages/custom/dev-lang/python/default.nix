{ python }:

python.withPackages (pythonPackages: with pythonPackages; [ scipy numpy pandas matplotlib sympy ])
