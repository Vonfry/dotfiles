nix-mode

(sys-flake
    "{" n>
        "inputs.nixpkgs.url = \"nixpkgs\";" n>
        "outputs = { self, nixpkgs }:" n>
            "let" n>
                "system = \"x86_64-linux\";" n>
                "pkgs = import nixpkgs {" n>
                    "config = { allowUnfree = true; };" n>
                    "localSystem = system;" n>
                "};" n>
            "in {" n>
                "devShell.${system} = with pkgs; mkShell {" n>
                "};" n>
            "};" n>
    "}"
)