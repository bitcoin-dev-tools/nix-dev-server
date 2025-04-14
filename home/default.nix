{ deployment, ... }: {

  # Create the setup directory and copy justfile and bitcoin directory
  systemd.tmpfiles.rules = [
    "d /home/${deployment.username}/setup - ${deployment.username} ${deployment.username} - -"
    "C /home/${deployment.username}/setup/.envrc - ${deployment.username} ${deployment.username} - ${./justfile}"
    "C /home/${deployment.username}/setup/bitcoin - ${deployment.username} ${deployment.username} - ${./bitcoin}"
    "C /home/${deployment.username}/setup/justfile - ${deployment.username} ${deployment.username} - ${./justfile}"
  ];

}
