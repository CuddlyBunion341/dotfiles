{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# console.font = "Lat2-Terminus16";

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
    wireless = {
      enable = false;
      networks = {};
    };
  };

  # networking.hostName = "nixos";
  #
  # networking.networkmanager.enable = true;
  # networking.wireless.enable = false;
  # networking.useDHCP = true;

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # services.displayManager.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.theme = "where_is_my_sddm_theme";
  
  users.users.dani = {
    isNormalUser = true;
    description = "Dani";
    extraGroups = [ "networkmanager" "wheel" "sound" "audio" "video" ];
    packages = with pkgs; [];
  };

  fonts.packages = with pkgs; [
    hack-font
      hackgen-nf-font
      terminus-nerdfont
  ];

# $ nix search wget
  environment.systemPackages = with pkgs; [
    krusader
      bemenu
      pulseaudio
      pulsemixer
      nnn

      lz4

      ruby_3_1
      bundix
      gnumake
      gcc
      lsof

      # nodejs_22

      fbterm
      eza
      bat
      # superfile

      bun

      vim
      neovim
      neovim-remote
      mc
      alacritty
      lazygit
      fzf
      gh
      tmux
      lynx
      hyprland
      sddm
      where-is-my-sddm-theme

      lynx
      fastfetch
      git
      zsh
      btop
      htop
      wget
      ripgrep

      firefox
      # kdePackages.dolphin
      discord

      hyprland
      hyprpaper

      lua-language-server
      rust-analyzer
      bundix
      cargo
      ];

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  programs.firefox = {
    enable = true;
    languagePacks = [ "de" "en-US" ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newtab";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";

      /* ---- EXTENSIONS ---- */
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/darkreader/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      Preferences = {
        extensions.activeThemeId = "4ae94ae4-df44-487a-bb8d-cdf0cb324144";
      };
    };
  };

  system.stateVersion = "24.05";
}
