{
  description = "HeitorAugustoLN's personal Helix configuration";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./flake);

  nixConfig = {
    commit-lockfile-summary = "chore(deps): update flake";
    extra-experimental-features = [ "pipe-operators" ];
    extra-substituters = [ "https://heitor.cachix.org" ];
    extra-trusted-public-keys = [ "heitor.cachix.org-1:IZ1ydLh73kFtdv+KfcsR4WGPkn+/I926nTGhk9O9AxI=" ];
  };

  inputs = {
    # keep-sorted start block=yes newline_separated=yes
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    helix = {
      type = "github";
      owner = "helix-editor";
      repo = "helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
    };

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "triplet";
    };

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted end
  };
}
