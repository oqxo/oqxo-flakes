#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="$(pwd)/cache"
mkdir -p "$CACHE_DIR"

# List all packages defined in your flake
packages=(
  jq cowsay bash devbox nodejs_22 nodejs_24 perl
  zulu24 zulu21 zulu17 zulu11 zulu8 maven
  python313 python312 brotli upx syft grype
  gnumake coreutils go nginx bun black uv alejandra
)

# List all devShells
devshells=(
  default java java21 java17 java11 java8
  python python312 nodejs go
)

echo "=== Step 1: Build all packages ==="
for pkg in "${packages[@]}"; do
  echo "Building package: $pkg"
  nix build .#packages.x86_64-linux.$pkg
done

echo "=== Step 2: Build all devShells ==="
for shell in "${devshells[@]}"; do
  echo "Building devShell: $shell"
  nix build .#devShells.x86_64-linux.$shell || echo "Warning: devShell $shell cannot be built directly (normal for mkShell)"
done

# echo "=== Step 3: Force-build all nested derivations for packages ==="
# for pkg in "${packages[@]}"; do
#   echo "Force-building derivations for package: $pkg"
#   for drv in $(nix path-info .#packages.x86_64-linux.$pkg --derivation --recursive); do
#     nix build "$drv" || echo "Warning: $drv failed"
#   done
# done

# echo "=== Step 4: Force-build all nested derivations for devShells ==="
# for shell in "${devshells[@]}"; do
#   echo "Force-building derivations for devShell: $shell"
#   for drv in $(nix path-info .#devShells.x86_64-linux.$shell --derivation --recursive); do
#     nix build "$drv" || echo "Warning: $drv failed"
#   done
# done

echo "=== Step 5: Copy package runtime closures to cache ==="
for pkg in "${packages[@]}"; do
  echo "Copying runtime closure for: $pkg"
  nix copy --to "file://$CACHE_DIR" $(nix path-info .#packages.x86_64-linux.$pkg)
  nix copy --to "file://$CACHE_DIR" $(nix path-info .#packages.x86_64-linux.$pkg --recursive)
done

echo "=== Step 6: Copy devShell runtime closures to cache ==="
for shell in "${devshells[@]}"; do
  nix copy --to "file://$CACHE_DIR" $(nix path-info .#devShells.x86_64-linux.$shell) || true
  nix copy --to "file://$CACHE_DIR" $(nix path-info .#devShells.x86_64-linux.$shell --recursive) || true
done

echo "=== Step 7: Copy derivation closures to cache ==="
for pkg in "${packages[@]}"; do
  nix copy --derivation --to "file://$CACHE_DIR" $(nix path-info .#packages.x86_64-linux.$pkg --derivation --recursive) \
    || echo "Warning: some derivations for $pkg could not be copied"
done

for shell in "${devshells[@]}"; do
  nix copy --derivation --to "file://$CACHE_DIR" $(nix path-info .#devShells.x86_64-linux.$shell --derivation --recursive) \
    || echo "Warning: some derivations for devShell $shell could not be copied"
done

echo "=== Build and cache complete: $CACHE_DIR ==="
