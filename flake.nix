{
  description = "My nix flake templates";

  outputs = { ... }:
  let
    mkTemplate = path: description: {
      inherit path description;
    };
  in{
    templates = {
      bun = mkTemplate ./bun "Bun template";
      clang = mkTemplate ./clang "Clang template";
      common = mkTemplate ./common "Common template";
      deno = mkTemplate ./deno "Deno template";
      dotnet = mkTemplate ./dotnet "Dotnet template";
      go = mkTemplate ./go "Go template";
      java = mkTemplate ./java "Java template";
      nodejs = mkTemplate ./nodejs "Nodejs template";
      python = mkTemplate ./python "Python template";
      rust = mkTemplate ./rust "Rust template";
      zig = mkTemplate ./zig "Zig template";
    };
  };
}
