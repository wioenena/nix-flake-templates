{
  description = "Rust template";

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
        default = pkgs.callPackage (
          {
            mkShell,
            rustup,
            rustPlatform,
          }:
          mkShell {
            strictDeps = true;
            nativeBuildInputs = with pkgs; [
              rustup
              rustPlatform.bindgenHook
            ];
            buildInputs = with pkgs; [ ];

            shellHook = ''
              echo "------------------------------------------------"
              echo "🦀 Welcome to the Rust development shell! 🦀"
              rustc --version
              cargo --version
              echo "------------------------------------------------"
            '';
          }
        ) { };
      });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
