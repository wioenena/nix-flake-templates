{
  description = "Node.js template";

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
            nodejs_latest
            pnpm
          ];
          buildInputs = with pkgs; [ ];

          shellHook = ''
            echo "------------------------------------------------"
            echo "Welcome to the Node.js development shell!"
            echo "Node version: $(node -v)"
            echo "PNPM version: $(pnpm -v)"
            echo "------------------------------------------------"
          '';
        };
      });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
