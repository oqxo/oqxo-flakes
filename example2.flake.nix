{
  description = "Flake with vendored nixpkgs from local tarball";

  inputs = {};

  outputs = { self }: 
    let
      vendoredNixpkgs = builtins.fetchTarball ./vendor/nixpkgs-25.05.tar.gz;
      pkgs = import vendoredNixpkgs {
        system = "aarch64-darwin";
      };
    in {
      packages.aarch64-darwin = {
        hello = pkgs.hello;
        cowsay = pkgs.cowsay;
        lolcat = pkgs.lolcat;
        wget = pkgs.wget;
      };

      devShells.aarch64-darwin.default = (import vendoredNixpkgs {
        system = "aarch64-darwin";
      }).mkShell {
        buildInputs = [
          pkgs.hello
          pkgs.cowsay
          pkgs.lolcat
          pkgs.wget
        ];
      };
    };
}
