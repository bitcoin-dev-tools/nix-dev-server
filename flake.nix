{
  description = "Bitcoin Core NixOS dev server with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Load deployments from JSON file
      deploymentsJson = builtins.fromJSON (builtins.readFile ./deployments.json);

      # Convert JSON to Nix format (camelCase keys, etc.)
      deployments = map
        (d: {
          username = d.username;
          hostname = d.hostname;
          ipAddress = d.ipAddress;
          isAdmin = d.isAdmin;
          sshKey = d.sshKey;
          timeZone = d.timeZone;
          locale = d.locale;
        })
        deploymentsJson;

      # fn to create NixOS configurations for a deployment
      mkDeployment = deployment:
        let
          userName = deployment.username;
          hostName = deployment.hostname;
          hostPath = ./hosts + "/${hostName}";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit deployment; };
          modules = [
            disko.nixosModules.disko
            (hostPath + "/configuration.nix")
            (if builtins.pathExists (hostPath + "/hardware-configuration.nix")
            then hostPath + "/hardware-configuration.nix"
            else { })
            ./modules/common.nix
            ./modules/development.nix
            ./modules/tmux.nix

            # Import user-specific configuration if it exists
            (if builtins.pathExists ./users/${userName}/default.nix
            then ./users/${userName}/default.nix
            else { })

            # Add Bitcoin Core helper setup scripts
            ./home/default.nix

            # Include Home Manager module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userName} = { pkgs, ... }: {
                home.stateVersion = "25.05";
                # Allow users to manage their own packages
                home.packages = [ ]; # Base packages (can be extended locally)
                # Import local user configuration if it exists
                imports =
                  let
                    localConfig = "/home/${userName}/.config/home-manager/home.local.nix";
                  in
                  if builtins.pathExists localConfig
                  then [ localConfig ]
                  else [ ];
              };
            }

            # Set up host and user configuration
            {
              networking.hostName = hostName;
              users.users.${userName} = {
                isNormalUser = true;
                extraGroups = [ "networkmanager" "docker" ]
                  ++ (if deployment.isAdmin then [ "wheel" ] else [ ]);
                openssh.authorizedKeys.keys = [ deployment.sshKey ];
              };
              environment.systemPackages = [ pkgs.home-manager ];
            }

          ];
        };

      # Generate configurations for all deployments
      nixosConfigs = builtins.listToAttrs (
        builtins.map
          (deployment: {
            name = deployment.username;
            value = mkDeployment deployment;
          })
          deployments
      );

    in
    {
      # All configurations
      nixosConfigurations = nixosConfigs;

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
