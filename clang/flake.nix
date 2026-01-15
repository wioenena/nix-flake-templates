{
  description = "C/C++ template";

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
            gcc
            clang
            cmake
            gnumake
            ninja
            pkg-config
            gdb
            clang-tools
          ];
          buildInputs = with pkgs; [ ];

          shellHook = ''
            echo "------------------------------------------------"
            echo "🛡️ Welcome to the C/C++ development shell!"
            echo "------------------------------------------------"
            echo "Compilers: GCC $(gcc --version | head -n1 | awk '{print $3}'), Clang $(clang --version | head -n1 | awk '{print $3}')"
            echo ""
            echo "Build Tools:"
            echo "  cmake          - Configure your project"
            echo "  make           - Build using Makefiles"
            echo "  ninja          - Faster builds (if configured)"
          '';
        };
      });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
