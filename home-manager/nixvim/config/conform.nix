{ pkgs, ... }: {
  extraPackages = with pkgs; [
    codespell
    go
    mdformat
    ruff
    rustfmt
    shellcheck
    shfmt
    stylua
    yamlfmt
  ];

  # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = false;
      formatters_by_ft = {
        bash = [
          "shfmt"
          "shellcheck"
        ];
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        go = [ "gofmt" ];
        lua = [ "stylua" ];
        markdown = [ "mdformat" ];
        python = [ "ruff_format" ];
        rust = [ "rustfmt" ];
        sh = [ "shfmt" "shellcheck" ];
        yaml = [ "yamlfmt" ];

        # "*" filetype to run formatters on all filetypes.
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
}
