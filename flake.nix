{
  description = "Flake utils demo";
  
  inputs.simulatorsrc = {
    url = "git+https://code.osu.edu/fehelectronics/proteus_software/simulator_c";
    flake = false;
  };

  inputs.firmwaresrc = {
    url = "git+https://code.osu.edu/fehelectronics/proteus_software/fehproteusfirmware";
    flake = false;
  };

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, simulatorsrc, firmwaresrc }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {inherit system;}; in
      {
        packages = rec {
          simulator = pkgs.stdenv.mkDerivation {
            name = "fehproteus-simulator";
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
          physical = pkgs.stdenv.mkDerivation {
            name = "fehproteus-physical";
            src = ./.;
            patchPhase = ''
              cp -r --dereference $firmwaresrc simulator_firmware
            '';
            nativeBuildInputs = with pkgs; [
              gcc-arm-embedded
            ];
            inherit firmwaresrc;
          };
          default = physical;
        };
      }
    );
}
