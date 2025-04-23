{ pkgs, ... }: {
  extraPackages = with pkgs; [
    basedpyright
    clang-tools
    cmake-language-server
    fish-lsp
    gitlint
    isort
    lua-language-server
    nil
    nodePackages.jsonlint
    ruff
    stylua
    typos
    typos-lsp
  ];

  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-cmdline.enable = true;
  plugins.cmp-nvim-lsp-signature-help.enable = true;

  # Useful status updates for LSP.
  # https://nix-community.github.io/nixvim/plugins/fidget/index.html
  plugins.fidget = {
    enable = true;
  };

  # https://nix-community.github.io/nixvim/plugins/lsp/index.html
  plugins.lsp = {
    enable = true;
    inlayHints = true;

    # Enable the following language servers
    #  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    #
    #  Add any additional override configuration in the following tables. Available keys are:
    #  - cmd: Override the default command used to start the server
    #  - filetypes: Override the default list of associated filetypes for the server
    #  - capabilities: Override fields in capabilities. Can be used to disable certain LSP features.
    #  - settings: Override the default settings passed when initializing the server.
    #        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    servers = {
      basedpyright = {
        enable = true;
      };
      clangd = {
        enable = true;
      };
      cmake = {
        enable = true;
      };
      fish_lsp = {
        enable = true;
      };
      gopls = {
        enable = true;
      };
      lua_ls = {
        enable = true;
        settings = {
          completion = {
            callSnippet = "Replace";
          };
        };
      };
      nil_ls = {
        enable = true;
      };
      ruff = {
        enable = true;
      };
      # typos_lsp = {
      #   enable = true;
      #   settings = {
      #     diagnosticSeverity = "Hint";
      #   };
      # };
    };

    keymaps = { };
  };
}
