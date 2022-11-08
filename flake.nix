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
            patchPhase = ''
              substituteInPlace Makefile --replace '-framework OpenGL -framework Cocoa' "$(pkg-config --libs opengl x11 glx)"
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
            inherit src;
          };
          default = feh-proteus;
        };
      }
    );
}
