{
  perSystem =
    { pkgs, self', ... }:
    {
      devShells = builtins.mapAttrs (
        _: helix:
        pkgs.mkShell {
          packages = [
            helix
            pkgs.just
          ];
        }
      ) self'.packages;
    };
}
