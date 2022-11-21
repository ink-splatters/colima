{
  description = "Container runtimes on macOS (and Linux) with minimal setup";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem
    (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = import ./colima.nix { inherit pkgs; };
        devShell = import ./shell.nix { inherit pkgs; };
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/colima";
        };
      }
    );
}
