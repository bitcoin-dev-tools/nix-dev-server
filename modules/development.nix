{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Languages and runtimes
    lua
    python3
    rustup
    uv

    # LSPs and linters etc.
    basedpyright
    clang-tools
    cmake-language-server
    fish-lsp
    gitlint
    isort
    nil
    lua-language-server
    nodePackages.jsonlint
    pyright
    ruff
    stylua
    typos
    typos-lsp

    # Git-related
    delta
    difftastic
    lazygit

    # Misc
    doxygen
  ];
}
