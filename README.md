# Bitcoin Core NixOS Dev configuration

## Files

- `flake.nix` - Flake configuration
- `configuration.nix` - General system configuration
- `disk-config.nix` - Disk layout
- `vars.nix` - User-specific variables

## Setup

You'll need `nix` installed locally, and it will need `nix-command` and
`flakes` enabled. This can be achieved by adding the following to
`/etc/nix/nix.conf`:

```bash
$ sudoedit /etc/nix/nix.conf

# add this line to the file
experimental-features = nix-command flakes
```

After adding this line, restart the `nix` daemon:

```bash
# Linux
sudo systemctl restart nix-daemon
# MacOS
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
```

## Usage

1. Modify the following lines in `vars.nix` to your own values, e.g.:

   ```nix
   username = "will";
   sshKey = "ssh-ed25519 <sshkey> email@address.com";
   ```

2. Configure the disk layout for the remote machine.

   Generally, this involves SSHing into the target machine and checking which
   disks are available:

   ```bash
   ssh <hostname>

   # On host
   ❯ lsblk
   NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
   sda             8:0    0 38.1G  0 disk
   ├─sda1          8:1    0    1M  0 part
   ├─sda2          8:2    0  500M  0 part /boot
   └─sda3          8:3    0 37.7G  0 part
     └─pool-root 254:0    0 37.7G  0 lvm  /nix/store
                                          /
   sr0            11:0    1 1024M  0 rom
   ```

   With this information you can configure the _./disk-config.nix_ file
   appropriately.

   Currently this is confgiured to use a standard GPT (GUID Partition Table)
   that is compatible with both EFI and BIOS systems and mounts the disk as
   `/dev/sda`. You may need to adjust `/dev/sda` to match the correct disk on
   your machine.

   If this setup does not match your requirements, you can choose an example
   that better suits your disk layout from the [disko
   examples](https://github.com/nix-community/disko/tree/master/example). For
   more detailed information, refer to the [disko
   documentation](https://github.com/nix-community/disko).

3. Lock your Flake

   ```
   nix flake lock
   ```

   This will download your flake dependencies and make a `flake.lock` file that
   describes how to reproducibly build your system.

   Optionally, you can commit these files to a repo such as Github.

4. Connectivity to the Target Machine

   **nixos-anywhere** will create a temporary SSH key to use for the
   installation. If your SSH key is not found, you will be asked for your
   password. If you are using a non-root user, you must have access to sudo
   without a password. To avoid SSH password prompts, set the `SSHPASS`
   environment variable to your password and add `--env-password` to the
   `nixos-anywhere` command. If providing a specific SSH key through `-i`
   (identity_file), this key will then be used for the installation and no
   temporary SSH key will be created.

   It's highly recommended to use an `~/.ssh/config` entry to configure ssh access to the host:

   ```
   cat ~/.ssh/config

   Host my-hostname
    HostName 123.456.789.1
    Port 22
    User root
    IdentityFile /path/to/my/ssh/key.pub
   ```

   This makes deploying and (remote) switching with the `justfile` much smoother.

5. Deploy

   It's recommended to allow `nixos-anywhere` to generate a hardware
   configuration during installation. This ensures that essential drivers, such
   as those required for disk detection, are properly configured.

   We use nixos-facter for this during the deployment, which can be done using
   the `justfile` helper, or manually:

   ```bash
   just deploy <hostname>
   # or
   nix-shell -p nixos-anywhere --run "nixos-anywhere --flake .#nixos --generate-hardware-config nixos-facter facter.json <hostname>"
   ```

6. Updating a deployed system

    1. Locally

       Ideally at this point you would commit this directory (including
       facter.json) to a git repo, and clone it on the host. Then (locally on
       the host) you would make your changes, add them to `git` (staging area
       or committed) and run `nixos-rebuild switch`.

       On this host:

       ```bash
       git add . && git commit -m "add facter.json"
       # Push to https://github.com/name/repo
       ```

       ... and on the remote host:

       ```bash
       git clone https://github.com/name/repo ~/nixos-config && cd ~/nixos-config

       just switch
       # or
       sudo nix-shell -p nixos-rebuild --run "nixos-rebuild switch --flake ."
       ```

    1. Remotely

       It's not best practice, but you _can_ make more changes here, add them
       to `git`, and run the appropriate justfile helper command to apply them
       remotely, but this is not recommended:

       ```bash
       just switch-remote <hostname>
       ```
