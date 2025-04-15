{ pkgs, ... }:
{
  home.stateVersion = "25.05";

  imports = [
    ./kickstart.nixvim/nixvim.nix
  ];

  home.packages = with pkgs; [
    # Add other user-specific packages here
  ];
}
