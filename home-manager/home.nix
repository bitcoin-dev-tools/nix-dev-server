{ pkgs, username, ... }:
{
  home.stateVersion = "25.05";

  imports = [
    ./kickstart.nixvim/nixvim.nix
  ];

  home.packages = with pkgs; [
    tokei
  ];

  programs.git = {
    enable = true;
    userName = "josibake";
    userEmail = "josibake@protonmail.com";

    signing = {
      key = "8ADCB558C4F33D65";
      signByDefault = true;
    };
  };

  systemd.user.tmpfiles.rules = [
    "d /home/${username}/flakes/bitcoin - ${username} users - -"
    "C /home/${username}/flakes/bitcoin/flake.nix 0744 ${username} users - ${./bitcoin/flake.nix}"
    "C /home/${username}/flakes/bitcoin/flake.lock 0744 ${username} users - ${./bitcoin/flake.lock}"
    "d /home/${username}/setup/bitcoin - ${username} users - -"
    "C /home/${username}/setup/bitcoin/justfile 0744 ${username} users - ${./bitcoin/justfile}"
    "C /home/${username}/setup/bitcoin/.envrc 0744 ${username} users - ${./bitcoin/.envrc}"
    "C /home/${username}/setup/justfile 0744 ${username} users - ${./justfile}"
  ];
}
