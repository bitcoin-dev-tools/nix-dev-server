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

### Adding packages

Nix packages can be found by searching https://search.nixos.org/packages

Generally it's considered best-practice to install packages needed for developement using a shell.nix or a flake, but "general" packages can be installed as below.

#### Ephemerally

To use one in an ephemeral environment run `nix-shell -p <package-name>`.

#### Persistently

Sometimes you may want packages installed persistently.
For this, we leverage home-manager which means you can add packages to `~/.config/home-manager/home.local.nix` and run:

```bash
home-manager switch
```

to install the new packages for your user.

## Nix-dev-server administrators

See the [Admin README](README-admin.md)
