{
  description = "Flake utils demo";
  
  inputs.simulatorsrc = {
    url = "git+https://code.osu.edu/fehelectronics/proteus_software/simulator_c";
    flake = false;
  };

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, simulatorsrc }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {inherit system;}; in
      {
        packages = rec {
          simulator = pkgs.stdenv.mkDerivation {
            name = "feh-proteus";
            patchPhase = ''
              cp --dereference $simulatorsrc/Makefile .
              cp --dereference -r $simulatorsrc/Libraries .
              chmod +w Libraries
              chmod +w Makefile
              substituteInPlace Makefile --replace '-framework OpenGL -framework Cocoa' "$(pkg-config --libs opengl x11 glx)"
            '';
            buildPhase = ''
              make main
            '';
            installPhase = ''
              mkdir -p $out/bin
              cp game.out $out/bin/feh-proteus
            '';
            nativeBuildInputs = with pkgs; [
              pkgconfig
            ];
            buildInputs = with pkgs; [
              xorg.libX11
              libGL
            ];
            src = ./.;
            inherit simulatorsrc;
          };
          default = simulator;
        };
      }
    );
}
