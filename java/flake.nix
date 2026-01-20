{
  description = "Java template";

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
            openjdk
            maven
            gradle
          ];
          buildInputs = with pkgs; [ ];

          shellHook = ''
            echo "------------------------------------------------"
            echo "Welcome to the Java development shell!"
            echo "------------------------------------------------"
            java -version
            echo "Maven version : $(mvn -v | head -n 1 | awk '{print $3}')"
            echo "Gradle version: $(gradle --version | grep Gradle | head -n 1 | awk '{print $2}')"
            echo "------------------------------------------------"
          '';
        };
      });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
