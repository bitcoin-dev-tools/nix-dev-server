{ pkgs, deployment, ... }:
let
  # Load admin key from JSON file
  adminKeyJson = builtins.fromJSON (builtins.readFile ../admin_key.json);
  adminKey = adminKeyJson.adminKey;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    curl
    direnv
    eza
    fd
    fzf
    gh
    git
    gnupg
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
  ];

  hardware.enableAllFirmware = true;

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
    nix-direnv = {
      enable = true;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      directory.truncation_length = 3;
      gcloud.disabled = true;
      aws.disabled = true;
      memory_usage.disabled = true;
      shlvl.disabled = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  # Configure root authorized keys
  users.users.root.openssh.authorizedKeys.keys = [
    adminKey
  ];


  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "yes";
      };
    };

    # YubiKey support, not sure how this works remotely...
    pcscd.enable = true; # Smart card daemon for Yubikey
    udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];

    # Remap caps lock to escape
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

    # TODO: do we want this enabled?
    i2pd.enable = true;
  };

  # Use timeZone and locale from deployment config, with fallbacks
  time.timeZone = if builtins.hasAttr "timeZone" deployment then deployment.timeZone else "UTC";
  i18n.defaultLocale = if builtins.hasAttr "locale" deployment then deployment.locale else "en_US.UTF-8";

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  system.stateVersion = "25.05";
}
