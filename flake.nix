{
    inputs = {
        flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
        flake-utils.url = "github:numtide/flake-utils";
        fenix = {
            url = "github:nix-community/fenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, flake-utils, ...}:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
                {
                    devShells.default = pkgs.mkShell rec {};
                }
        );
}