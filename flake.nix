{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-bitcoin = {
      url = "github:2140-dev/nix-bitcoin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, nvf, home-manager, nix-bitcoin, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      vars = import ./vars.nix;
    in
    {
      nixosConfigurations."2140" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit pkgs; username = vars.username; };
            home-manager.users.${vars.username} = {
              imports = [
                nvf.homeManagerModules.default
                ./home-manager/home.nix
              ];
            };
          }
          # nix-bitcoin is pulled in as a module and and the configurations
          # are set here, but the actual service is activated in ./configuration.nix?
          # unsure what the standard is but for now configuring the packages
          # in the flake and then activating them in config.nix seems fine
          nix-bitcoin.nixosModules.default
          {
            nix-bitcoin.operator = { enable = true; name = vars.username; };
            nix-bitcoin.generateSecrets = true;
          }
          ./configuration.nix
          {
            _module.args = {
              username = vars.username;
              sshKey = vars.sshKey;
            };
          }
        ];
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
