{
  description = "Dev Tools";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          lib,
          ...
        }:
        let
          inherit (pkgs) mkShell;
          inherit (lib) getExe;

          onefetch = getExe pkgs.onefetch;
        in
        {
          imports = [
            ./pkgs
          ];

          devShells.default = mkShell {
            name = "dev-tools.nix";

            packages = [ ];

            shellHook = ''
              echo 'Installing pre-commit hooks...'
              ${onefetch} --no-bots
            '';
          };
        };
    };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
