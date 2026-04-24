{ inputs, lib, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          just.enable = true;
          keep-sorted.enable = true;

          nixf-diagnose = {
            enable = true;
            priority = -1;
          };

          nixfmt = {
            enable = true;
            strict = true;
          };

          prettier = {
            enable = true;
            includes = [ "*.md" ];
          };

          shellcheck.enable = true;
          shfmt.enable = true;
          yamlfmt.enable = true;
        };

        settings = {
          formatter.tombi = {
            command = lib.getExe pkgs.tombi;

            options = [
              "format"
              "--offline"
            ];

            includes = [ "*.toml" ];
          };

          on-unmatched = "info";
        };
      };
    };
}
