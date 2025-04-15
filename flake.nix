{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs
    , disko
    , nixvim
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      vars = import ./vars.nix;
    in
    {
      # nixos-anywhere --flake .#nixos <hostname>
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          nixvim.nixosModules.nixvim
          {
            _module.args = {
              username = vars.username;
              sshKey = vars.sshKey;
              inputs = {
                nixvim = nixvim;
              };
            };
          }
        ];
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
