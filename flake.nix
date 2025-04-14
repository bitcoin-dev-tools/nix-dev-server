{
  description = "Bitcoin Core NixOS dev configuration";

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

      # Common variables we can pass to other modules
      username = "will";
      sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH988C5DbEPHfoCphoW23MWq9M6fmA4UTXREiZU0J7n0 will.hetzner@temp.com";
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager

          # Pass variables to other modules
          {
            _module.args = {
              inherit username sshKey;
            };
          }
        ];
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
