{
  description = "Flake with vendored nixpkgs from local tarball";

  inputs = {};

  outputs = { self }: 
    let
      pkgs = import (builtins.fetchTarball {
        url = "file://${toString ./.}/vendor/nixpkgs-25.05.tar.gz";
      }) {
        system = "aarch64-darwin";
      };
    in {
      packages.aarch64-darwin = {
        hello = pkgs.hello;
        cowsay = pkgs.cowsay;
        lolcat = pkgs.lolcat;
        wget = pkgs.wget;
      };

      devShells.aarch64-darwin.default = pkgs.mkShell {
        buildInputs = [
          pkgs.hello
          pkgs.cowsay
          pkgs.lolcat
          pkgs.wget
        ];
      };
    };
}
