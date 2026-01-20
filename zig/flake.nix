{
  description = "Zig template";

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
            zig
            zls
          ];
          buildInputs = with pkgs; [ ];

          shellHook = ''
            echo "------------------------------------------------"
            echo "⚡ Welcome to the Zig development shell! ⚡"
            zig version
            echo "------------------------------------------------"
          '';
        };
      });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
