{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    {
      nixpkgs,
      disko,
      ...
    }:
    let
      vars = import ./vars.nix;
    in
    {
      # nixos-anywhere --flake .#nixos <hostname>
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          {
            _module.args = {
              username = vars.username;
              sshKey = vars.sshKey;
            };
          }
        ];
      };
    };
}
