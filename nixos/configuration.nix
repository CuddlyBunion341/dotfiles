{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# console.font = "Lat2-Terminus16";

  networking.hostName = "nixos";
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dani = {
    isNormalUser = true;
    description = "Dani";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  fonts.packages = with pkgs; [
    hack-font
      hackgen-nf-font
      terminus-nerdfont
  ];

# $ nix search wget
  environment.systemPackages = with pkgs; [
    fbterm
      eza

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
      lynx
      fastfetch
      git
      zsh
      btop
      wget
      ripgrep

      firefox
      kdePackages.dolphin
      discord
      krusader
      ];

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  # programs.dolphin.enable = true;
# programs.fbterm.enable = true;

  programs.firefox = {
    enable = true;
    languagePacks = [ "de" "en-US" ];

    # profiles = {
    #   myProfile = {
    #     settings = {
    #       extensions.activeThemeID = "4ae94ae4-df44-487a-bb8d-cdf0cb324144";
    #     };
    #   };
    # };

    /* ---- POLICIES ---- */
# Check about:policies#documentation for options.
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
      DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"

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

      /* ---- PREFERENCES ---- */
# Check about:config for options.
      Preferences = {
      extensions.activeThemeId = "4ae94ae4-df44-487a-bb8d-cdf0cb324144";
# "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
# "extensions.pocket.enabled" = lock-false;
# "extensions.screenshots.disabled" = lock-true;
# "browser.topsites.contile.enabled" = lock-false;
# "browser.formfill.enable" = lock-false;
# "browser.search.suggest.enabled" = lock-false;
# "browser.search.suggest.enabled.private" = lock-false;
# "browser.urlbar.suggest.searches" = lock-false;
# "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
# "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
# "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
# "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
# "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
# "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
# "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
# "browser.newtabpage.activity-stream.showSponsored" = lock-false;
# "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
# "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };
    };
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
