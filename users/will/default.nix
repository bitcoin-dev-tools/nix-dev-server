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
