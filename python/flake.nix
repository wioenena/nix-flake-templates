{
  description = "Python template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      allSystems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f (import nixpkgs { inherit system; }));
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python3
            python3Packages.pip
            python3Packages.virtualenv
          ];
          buildInputs = with pkgs; [ ];

          shellHook = ''
            echo "------------------------------------------------"
            echo "🐍 Welcome to the Python development shell! 🐍"
            echo "Python version: $(python3 --version)"
          '';
        };
      });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
