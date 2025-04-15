{ username, ... }: {

  # Create a setup directory and copy files to it.
  systemd.tmpfiles.rules = [
    "d /home/${username}/setup - ${username} users - -"
    "d /home/${username}/setup/bitcoin - ${username} users - -"
    "C /home/${username}/setup/bitcoin/shell.nix 0744 ${username} users - ${./bitcoin/shell.nix}"
    "C /home/${username}/setup/bitcoin/justfile 0744 ${username} users - ${./bitcoin/justfile}"
    "d /home/${username}/setup/env - ${username} users - -"
    "C /home/${username}/setup/env/.envrc 0744 ${username} users - ${./env/.envrc}"
    "C /home/${username}/setup/justfile 0744 ${username} users - ${./justfile}"
  ];

}
