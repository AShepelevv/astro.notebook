{
  outputs =
    { ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSystem =
        f:
        builtins.listToAttrs (
          builtins.map (system: {
            name = system;
            value = f system;
          }) systems
        );
    in
    {
      packages = forEachSystem (system: {
        default = import ./default.nix { inherit system; };
      });
      devShells = forEachSystem (system: {
        default = (import ./default.nix { inherit system; }).shell;
      });
    };
}
