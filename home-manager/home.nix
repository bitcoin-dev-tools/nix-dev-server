{
  pkgs,
  username,
  ...
}: {
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    tokei
  ];

  programs.nvf = {
    enable = true;

    # my most commonly used languages
    settings.vim = {
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };
      lsp = {
        enable = true;
        formatOnSave = true;
      };
      languages = {
        enableTreesitter = true;

        # most commonly used
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;

        # less frequently used
        # TODO: find a way to turn off type checking with basedpyright
        # without this, the lsp is unusable with the bitcoin core functional
        # test framework due to all of the unknown type errors
        # python.enable = true;
        sql.enable = true;
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "josibake";
    userEmail = "josibake@protonmail.com";

    signing = {
      key = "8ADCB558C4F33D65";
      signByDefault = true;
    };
    ignores = [
      ".envrc"
      ".direnv/"
      ".cache/"
      # temporary hack - i copy justfiles into projects that
      # dont/wont upstream the justfile, so its easier to just
      # ignore it globally for now
      "justfile"
    ];
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
