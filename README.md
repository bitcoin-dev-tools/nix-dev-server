# NixOS Dev Server Configuration

- A NixOS configuration for bitcoin development servers.
- Generic over users and hosts.

## Nix-dev-server users

Bitcoin Core requires various build inputs which are best handled by a dedicated nix environment.
This is usually a shell.nix or a nix flake.

To aid this setup, a justfile script is provided in `/home/$USER/setup` which will amend the bitcoin core source directory to provide this automatically.

Configure this by doing the following:

```bash
mkdir $HOME/src
git clone https://github.com/bitcoin/bitcoin /home/$USER/src/

cd $HOME/setup
just setup /home/$USER/src/bitcoin
```

The `direnv` tool will, after one-time setup, activate the required shell automatically whenever entering this directory (or children).

## Nix-dev-server administrators

See the [Admin README](README-admin.md)
