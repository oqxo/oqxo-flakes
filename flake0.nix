{
  description = "OQXO-Flakes with chainloop as internal package";

  inputs = {
    nixpkgs.url = "path:./inputs/nixpkgs-25.05.tar.gz";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      internalChainloop = import ./chainloop { inherit pkgs; };
    in
    {
      packages.x86_64-linux = {
        jq          = pkgs.jq;
        cowsay      = pkgs.cowsay;
        bash        = pkgs.bash;
        devbox      = pkgs.devbox;
        nodejs_22   = pkgs.nodejs_22;
        nodejs_24   = pkgs.nodejs_24;
        perl        = pkgs.perl;
        zulu24      = pkgs.zulu24;
        zulu21      = pkgs.zulu21;
        zulu17      = pkgs.zulu17;
        zulu11      = pkgs.zulu11;
        zulu8       = pkgs.zulu8;
        maven       = pkgs.maven;
        python313   = pkgs.python313;
        python312   = pkgs.python312;
        brotli      = pkgs.brotli;
        upx         = pkgs.upx;
        syft        = pkgs.syft;
        grype       = pkgs.grype;
        gnumake     = pkgs.gnumake;
        coreutils   = pkgs.coreutils;
        go          = pkgs.go;
        nginx       = pkgs.nginx;
        bun         = pkgs.bun;
        black       = pkgs.black;
        uv          = pkgs.uv;
        alejandra   = pkgs.alejandra;
        chainloop   = internalChainloop;
      };

      formatter.x86_64-linux = pkgs.alejandra;

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
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

      devShells.x86_64-linux.java = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.maven
          pkgs.zulu24
        ];
      };

      devShells.x86_64-linux.java21 = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.maven
          pkgs.zulu21
        ];
      };

      devShells.x86_64-linux.java17 = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.maven
          pkgs.zulu17
        ];
      };

      devShells.x86_64-linux.java11 = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.maven
          pkgs.zulu11
        ];
      };

      devShells.x86_64-linux.java8 = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.maven
          pkgs.zulu8
        ];
      };

      devShells.x86_64-linux.python = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.python313
          pkgs.black
          pkgs.uv
        ];
      };

      devShells.x86_64-linux.python312 = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.python312
          pkgs.black
          pkgs.uv
        ];
      };

      devShells.x86_64-linux.nodejs = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.nodejs_24
          pkgs.bun
        ];
      };

      devShells.x86_64-linux.go = pkgs.mkShell {
        packages = [
          pkgs.bash
          pkgs.devbox
          pkgs.gnumake
          pkgs.upx
          pkgs.syft
          pkgs.grype
          pkgs.go
        ];
      };
    };
}
