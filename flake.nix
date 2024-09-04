{
    inputs = {
        flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
        flake-utils.url = "github:numtide/flake-utils";
        fenix = {
            url = "github:nix-community/fenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixpkgs.url = "nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, flake-utils, fenix, ...}:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
                rust' = (fenix.packages.${system}.complete.withComponents [
                    "cargo"
                    "clippy"
                    "rust-src"
                    "rustc"
                    "rustfmt"
                ]);
            in
                {
                    devShells.default = pkgs.mkShell rec {
                        nativeBuildInputs = with pkgs; [
                            rust'
                        ];
                    };
                }
        );
}