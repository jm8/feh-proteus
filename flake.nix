{
  description = "Flake utils demo";
  
  inputs.src = {
    url = "git+https://code.osu.edu/fehelectronics/proteus_software/simulator_c";
    flake = false;
  };

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, src }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {inherit system;}; in
      {
        packages = rec {
          feh-proteus = pkgs.stdenv.mkDerivation {
            name = "feh-proteus";
            inherit src;
          };
          default = feh-proteus;
        };
      }
    );
}
