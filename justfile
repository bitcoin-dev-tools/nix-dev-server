set shell := ["bash", "-uc"]

[private]
default:
    just --list

# Get IP address for a username from deployments.json
[private]
get-ip-address user:
    @jq -r '.[] | select(.username == "{{user}}") | .ipAddress' deployments.json

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
deploy user:
    nix-shell -p nixos-anywhere --run "nixos-anywhere --flake .#{{user}} `just get-ip-address {{user}}`"

# Update a configuration on a remote machine
[group('live')]
switch user:
    nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#{{user}} --target-host `just get-ip-address {{user}}` --impure"
