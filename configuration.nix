{
  modulesPath,
  pkgs,
  sshKey,
  username,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Basic tools
    bat
    curl
    direnv
    eza
    fd
    fzf
    gh
    git
    gnupg
    home-manager
    htop
    jq
    just
    keyd
    magic-wormhole
    mosh
    ncdu
    neovim
    nettools
    pinentry
    pinentry-curses
    pinentry-tty
    ripgrep
    rsync
    starship
    time
    tor
    wget
    wl-clipboard
    yubikey-manager
    yubikey-personalization
    zoxide

    # Development tools
    basedpyright
    clang-tools
    cmake-language-server
    delta
    difftastic
    doxygen
    fish-lsp
    gitlint
    isort
    lazygit
    lua
    lua-language-server
    nil
    nodePackages.jsonlint
    pyright
    python3
    ruff
    rustup
    stylua
    typos
    typos-lsp
    uv
  ];

  programs.git = {
    enable = true;
    package = pkgs.git;
    config = {
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "${pkgs.neovim}/bin/nvim";
      gpg.program = "${pkgs.gnupg}/bin/gpg2";
    };
  };

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      directory.truncation_length = 3;
      gcloud.disabled = true;
      aws.disabled = true;
      memory_usage.disabled = true;
      shlvl.disabled = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    historyLimit = 50000;
    terminal = "tmux-256color";
    keyMode = "vi";
    extraConfig = ''
      # Pass through ghostty capabilites
      set -ga terminal-overrides ",xterm-ghostty:*"

      # unbind the prefix and bind it to Ctrl-a like screen
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # copy to clipboard
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe 'wl-copy &> /dev/null'
      bind -T copy-mode-vi Enter send-keys -X cancel

      # shortcut for moving tmux buffer to clipboard
      # useful if you've selected with the mouse
      bind-key -nr C-y run "tmux show-buffer | xclip -in -selection clipboard &> /dev/null"

      # Avoid ESC delay
      set -s escape-time 0

      # Fix titlebar
      set -g set-titles on
      set -g set-titles-string "#T"

      # VIM mode
      set -g mode-keys vi

      # Mouse friendly
      set -g mouse on

      # Move between panes with vi keys
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Avoid date/time taking up space
      set -g status-right ""
      set -g status-right-length 0

      # Focus events for vim?
      set-option -g focus-events on

      # Switch to last window
      bind-key L last-window

      # Avoid env vars mangling with tmux and direnv
      # https://github.com/direnv/direnv/wiki/Tmux
      set-option -g update-environment "DIRENV_DIFF DIRENV_DIR DIRENV_WATCHES"
      set-environment -gu DIRENV_DIFF
      set-environment -gu DIRENV_DIR
      set-environment -gu DIRENV_WATCHES
      set-environment -gu DIRENV_LAYOUT
    '';
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "docker" "wheel" ];
    openssh.authorizedKeys.keys = [ sshKey ];
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [ sshKey ];
  };

  # Don't require a root password for `sudo` from "wheel" users
  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "yes";
      };
    };

    # YubiKey support
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];

    # Remap caps lock to escape, because we're elite
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              "capslock" = "esc";
            };
          };
        };
      };
    };

    i2pd.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # System version
  system.stateVersion = "25.05";
}
