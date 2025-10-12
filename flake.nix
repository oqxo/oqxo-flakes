{
  description = "OQXO-Flakes";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/25.05";

  outputs = {nixpkgs, ...}: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    # Expose multiple versions individually
    packages.x86_64-linux = {
      jq = pkgs.jq;
      cowsay = pkgs.cowsay;
      bash = pkgs.bash;
      devbox = pkgs.devbox;
      nodejs_22 = pkgs.nodejs_22;
      nodejs_24 = pkgs.nodejs_24;
      perl = pkgs.perl;
      zulu24 = pkgs.zulu24;
      zulu21 = pkgs.zulu21;
      zulu17 = pkgs.zulu17;
      zulu11 = pkgs.zulu11;
      zulu8 = pkgs.zulu8;
      maven = pkgs.maven;
      python313 = pkgs.python313;
      python312 = pkgs.python312;
      brotli = pkgs.brotli;
      upx = pkgs.upx;
      syft = pkgs.syft;
      grype = pkgs.grype;
      gnumake = pkgs.gnumake;
      coreutils = pkgs.coreutils;
      go = pkgs.go;
      nginx = pkgs.nginx;
      bun = pkgs.bun;
      black = pkgs.black;
      uv = pkgs.uv;
      alejandra = pkgs.alejandra;
    };

    # Default formatter for nix fmt
    formatter.x86_64-linux = pkgs.alejandra;

    # Default devShell (latest versions)
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

    # Java developer shells
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

    # Python developer shells
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

    # Node developer shell
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

    # Go developer shell
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
