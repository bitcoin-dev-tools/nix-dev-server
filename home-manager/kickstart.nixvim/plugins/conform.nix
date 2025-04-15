{ pkgs, ... }: {
  programs.nixvim = {
    # Dependencies
    #
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extrapackages
    extraPackages = with pkgs; [
      # Used to format Lua code
      codespell
      ruff
      rustfmt
      shellcheck
      shfmt
      stylua
    ];

    # Autoformat
    # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = false;
        formatters_by_ft = {
          bash = [
            "shellcheck"
            "shfmt"
          ];
          cpp = [ "clang_format" ];
          lua = [ "stylua" ];
          python = [ "ruff" ];
          rust = [ "rustfmt" ];

          # Conform can also run multiple formatters sequentially
          # python = [ "isort "black" ];
          #
          # You can use a sublist to tell conform to run *until* a formatter
          # is found
          # javascript = [ [ "prettierd" "prettier" ] ];

          # Use the "*" filetype to run formatters on all filetypes.
          "*" = [ "codespell" ];
        };
      };
    };

    # https://nix-community.github.io/nixvim/keymaps/index.html
    keymaps = [
      {
        mode = "";
        key = "<leader>f";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {
          desc = "[F]ormat buffer";
        };
      }
    ];
  };
}
