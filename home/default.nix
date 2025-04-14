{ deployment, ... }: {

  # Create the setup directory and copy justfile and bitcoin directory
  systemd.tmpfiles.rules = [
    "d /home/${deployment.username}/setup - ${deployment.username} users - -"
    "d /home/${deployment.username}/setup/bitcoin - ${deployment.username} users - -"
    "C /home/${deployment.username}/setup/bitcoin/flake.nix - ${deployment.username} users - ${./bitcoin/flake.nix}"
    "C /home/${deployment.username}/setup/env/.envrc - ${deployment.username} users - ${./env/.envrc}"
    "C /home/${deployment.username}/setup/justfile - ${deployment.username} users - ${./justfile}"
  ];

}
