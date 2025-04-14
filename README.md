# Bitcoin Core NixOS Dev configuration

## Files

- `configuration.nix` - Main system configuration
- `hardware-configuration.nix` - Hardware-specific configuration
- `home-manager.nix` - Home Manager configuration
- `flake.nix` - Flake configuration

## Usage

To use this configuration:

1. Modify the following lines in `configuration.nix` to your own values:

```nix
username = "will";
sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH988C5DbEPHfoCphoW23MWq9M6fmA4UTXREiZU0J7n0 will.hetzner@temp.com";
```

2. For an initial deployment to a fresh machine:

```bash
nix-shell -p nixos-anywhere --run "nixos-anywhere --flake .#default <hostname>"
```

3. To "switch" to a new version (i.e. after making changes to this configuration):

```bash
nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake .#default --target-host <hostname>"
```

## Customization

To customize the configuration:

- Edit `configuration.nix` to modify system-wide settings
- Edit `home-manager.nix` to modify user-specific settings
- Create a local override file at `/home/will/.config/home-manager/home.local.nix` for user-specific customizations
