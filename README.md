# NixOS Dev Server Configuration

- A NixOS configuration for bitcoin development servers.
- Generic over users and hosts.

## Structure

- `deployments.json` - Configuration for all deployments (users, hosts, SSH keys, etc.)
- `flake.nix` - NixOS configuration that reads from deployments.json
- `hosts/` - Host-specific configurations
- `users/` - User-specific configurations
- `modules/` - Shared NixOS modules

## Usage

### Managing Deployments

All deployments are defined in the `deployments.json` file. Each deployment includes:

- `username` - The username for the account (used as the configuration identifier)
- `hostname` - The hostname to use (corresponds to a folder in `hosts/`)
- `ipAddress` - IP address for deployment (used automatically by justfile)
- `isAdmin` - Whether to add the user to the wheel group
- `sshKey` - The user's SSH public key for authentication
- `timeZone` - The timezone for the user (e.g., "Europe/London")
- `locale` - The locale for the user (e.g., "en_GB.UTF-8")

### Managing Hosts

To add a new host:

1. Add a deployment with this host to the `deployments.json` file
2. Create the host configuration directory and files:
   ```bash
   mkdir -p hosts/<hostname>
   # Create a basic configuration.nix
   # Create hardware-configuration.nix if needed
   ```

### Managing Users

User-specific configurations are stored in the `users/<username>/default.nix` file. When a deployment is created with a username, the system will check if a corresponding configuration exists and include it.

To customize a user's configuration:

```bash
mkdir -p users/<username>
# Create or copy a user configuration
$EDITOR users/<username>/default.nix
```

### Deployment

To deploy a configuration:

```bash
just deploy <username>
```

Where:
- `username` is the user defined in the deployments.json file
- The IP address is automatically retrieved from deployments.json

### Other Commands

- `just build <username>` - Build configuration without deploying
- `just build-vm <username>` - Build a VM for testing
- `just dry-run <username>` - Show what would change without building
- `just switch <username>` - Update an existing deployment

## Customization

### User Configuration

Each user can have their own configuration defined in `users/<username>/default.nix`. This file receives the `deployment` parameter with all user-specific settings from the flake:

```nix
{ pkgs, deployment, ... }: {
  # User-specific configuration for ${deployment.username}

  environment.systemPackages = with pkgs; [
    # Add user-specific packages here
  ];

  programs = {
    # Add user-specific program configurations here
  };

  services = {
    # Add user-specific service configurations here
  };
}
```

### Host Configuration

Each host has its own configuration:

```bash
$EDITOR hosts/<hostname>/configuration.nix
```

## Example Deployment

1. Add a deployment to `deployments.json`:

```json
[
  {
    "username": "btcdev",
    "hostname": "server1",
    "ipAddress": "192.168.1.100",
    "isAdmin": true,
    "sshKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5... btcdev@example.com",
    "timeZone": "UTC",
    "locale": "en_US.UTF-8"
  }
]
```

2. Create the host configuration:

# TODO: Probably guide through https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md ?
```bash
mkdir -p hosts/server1

# Do more things...
```

3. Create a user-specific configuration (optional):

```bash
mkdir -p users/btcdev
cp users/will/default.nix users/btcdev/
$EDITOR users/btcdev/default.nix
```

4. Deploy the configuration:

```bash
just deploy btcdev
```

5. Make modifications and rebuild:

```bash
$EDITOR users/btcdev/default.nix
just switch btcdev
```
