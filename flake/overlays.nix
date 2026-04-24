{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.overlays = {
    default = self.overlays.stable;

    stable = final: prev: {
      hx = prev.callPackage (
        {
          lib,
          stdenv,
          symlinkJoin,
          makeWrapper,
          linkFarm,
          helix,

          wayland,
          wl-clipboard,

          nixfmt,
          tombi,

          just-lsp,
          nixd,
        }:
        symlinkJoin {
          inherit (helix) name meta;

          nativeBuildInputs = [ makeWrapper ];
          paths = [ helix ];

          postBuild =
            let
              xdgConfigHome = linkFarm "helix-xdg-config" [
                {
                  name = "helix";
                  path = ../helix;
                }
              ];
            in
            ''
              wrapProgram "$out/bin/hx" \
                --set XDG_CONFIG_HOME ${xdgConfigHome} \
                --prefix PATH : ${
                  let
                    packages =
                      let
                        externalTools = lib.optionalAttrs (lib.meta.availableOn stdenv.hostPlatform wayland) {
                          inherit wl-clipboard;
                        };

                        formatters = {
                          nix = nixfmt;
                          toml = tombi;
                        };

                        languageServers = {
                          just = just-lsp;
                          nix = nixd;
                          toml = tombi;
                        };
                      in
                      [
                        externalTools
                        formatters
                        languageServers
                      ]
                      |> builtins.concatMap builtins.attrValues
                      |> lib.flatten
                      |> lib.unique;
                  in
                  lib.makeBinPath packages
                }
            '';
        }
      ) { };
    };

    nightly = lib.composeManyExtensions [
      inputs.helix.overlays.helix
      self.overlays.stable
    ];
  };
}
