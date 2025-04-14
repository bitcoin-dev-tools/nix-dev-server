{ deployment, ... }: {

  # Create the setup directory and copy justfile and bitcoin directory
  systemd.tmpfiles.rules = [
    "d /home/${deployment.username}/setup - ${deployment.username} users - -"
    "d /home/${deployment.username}/setup/bitcoin - ${deployment.username} users - -"
    "C /home/${deployment.username}/setup/bitcoin/shell.nix - ${deployment.username} users - ${./bitcoin/shell.nix}"
    "C /home/${deployment.username}/setup/bitcoin/justfile - ${deployment.username} users - ${./bitcoin/justfile}"
    "d /home/${deployment.username}/setup/env - ${deployment.username} users - -"
    "C /home/${deployment.username}/setup/env/.envrc - ${deployment.username} users - ${./env/.envrc}"
    "C /home/${deployment.username}/setup/justfile - ${deployment.username} users - ${./justfile}"
  ];

}
