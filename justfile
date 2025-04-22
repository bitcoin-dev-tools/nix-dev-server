nixos_rebuild_args := if arch() != "x86_64" { "" } else { "--build-on-remote" }

[private]
default:
    just --list

# Deploy
[group('deploy')]
deploy hostname:
    nix-shell -p nixos-anywhere --run "nixos-anywhere --flake .#nixos {{hostname}} {{nixos_rebuild_args}}"

# Update configuration remotely
[group('rebuild')]
switch-remote hostname:
    nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#nixos --target-host {{hostname}}"

# Update configuration locally
[group('rebuild')]
switch:
    sudo nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#nixos"
