{ username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "25.05";

    home.packages = with pkgs; [
      # Add extra user packages here.
    ];

    programs = {
      # Add extra program configurations here.
    };

    services = {
      # Add extra service configurations here.
    };

    # Allow local overrides
    # On the remote host modifying ~/.config/home-manager/home.local.nix and running
    # `home-manager switch` will update the system.
    imports =
      let
        localConfig = "/home/${username}/.config/home-manager/home.local.nix";
      in
      if builtins.pathExists localConfig
      then [ localConfig ]
      else [ ];
  };
}
