[private]
default:
    just --list

# Deploy
[group('deploy')]
deploy hostname:
    nix-shell -p nixos-anywhere --run "nixos-anywhere --flake .#nixos {{hostname}}"

# Update configuration remotely
[group('rebuild')]
switch-remote hostname:
    nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#nixos --target-host {{hostname}}"

# Update configuration locally
[group('rebuild')]
switch:
    sudo nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#nixos"
