set shell := ["bash", "-uc"]

[private]
default:
    just --list

# Build configuration without deploying
[group('test')]
build user:
    nix-shell -p nixos-rebuild --run "nixos-rebuild build --flake .#{{user}} --show-trace"

# Build VM for testing
[group('test')]
build-vm user:
    nix-shell -p nixos-rebuild --run "nixos-rebuild build-vm --flake .#{{user}} --show-trace"

# Show what would change without building
[group('test')]
dry-run user:
    nix-shell -p nixos-rebuild --run "nixos-rebuild dry-run --flake .#{{user}} --show-trace"

# Deploy a new configuration to a remote machine
[group('live')]
deploy user hostname:
    nix-shell -p nixos-anywhere --run "nixos-anywhere --flake .#{{user}} {{hostname}}"

# Update a configuration on a remote machine
[group('live')]
switch user hostname:
    nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#{{user}} --target-host {{hostname}} --impure"
