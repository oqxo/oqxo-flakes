{
  description = "OQXO-Flakes (vendor-based curated packages and devshells)";

  inputs = {};

  outputs = { self, ... }:
    let
      # Helper to import vendored nixpkgs per system
      nixpkgsFor = system:
        import (builtins.fetchTarball {
          url = "file://${toString ../vendor/nixpkgs-cb82756ecc37fa623f8cf3e88854f9bf7f64af93.tar.gz}";
          sha256 = "sha256:1a28dlvrh2y1mps04f0mzb56syhkjd60zvr60brirvsgbrmcx46h";
        }) { system = system; config.allowUnfree = true; };
    in
    {
      # Expose curated packages
      packages = {
        x86_64-linux = let pkgs = nixpkgsFor "x86_64-linux"; in {
          jq        = pkgs.jq;
          cowsay    = pkgs.cowsay;
          bash      = pkgs.bash;
          devbox    = pkgs.devbox;
          nodejs_22 = pkgs.nodejs_22;
          nodejs_24 = pkgs.nodejs_24;
          perl      = pkgs.perl;
          zulu24    = pkgs.zulu24;
          zulu21    = pkgs.zulu21;
          zulu17    = pkgs.zulu17;
          zulu11    = pkgs.zulu11;
          zulu8     = pkgs.zulu8;
          maven     = pkgs.maven;
          python313 = pkgs.python313;
          python312 = pkgs.python312;
          brotli    = pkgs.brotli;
          upx       = pkgs.upx;
          syft      = pkgs.syft;
          grype     = pkgs.grype;
          gnumake   = pkgs.gnumake;
          coreutils = pkgs.coreutils;
          go        = pkgs.go;
          nginx     = pkgs.nginx;
          bun       = pkgs.bun;
          black     = pkgs.black;
          uv        = pkgs.uv;
          alejandra = pkgs.alejandra;
        };
      };

      # Expose devShells
      devShells = {
        x86_64-linux = let pkgs = nixpkgsFor "x86_64-linux"; in {
          devex = pkgs.mkShell {
            buildInputs = [
              pkgs.jq
              pkgs.wget
              pkgs.cowsay
              pkgs.hello
              pkgs.bash
              pkgs.devbox
              pkgs.gnumake
              pkgs.upx
              pkgs.syft
              pkgs.grype
              pkgs.zulu24
              pkgs.maven
              pkgs.python313
              pkgs.nodejs_24
              pkgs.go
              pkgs.bun
            ];
          };
        };
      };
    };
}
