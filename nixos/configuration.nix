 # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # console.font = "Lat2-Terminus16";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fbterm
    eza

    alacritty-themes

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
    firefox
    fastfetch
    krusader
    git
    zsh
    btop
    wget
    ripgrep
  ];

  # environment.systemPackages = [
  #   pkgs.nodePackages."@squoosh/cli"
  # ];

  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  # programs.fbterm.enable = true;

   programs.firefox = {
   # enable = true;
   # languagePacks = [ "de" "en-US" ];

   # /* ---- POLICIES ---- */
   # # Check about:policies#documentation for options.
   # policies = {
   #   DisableTelemetry = true;
   #   DisableFirefoxStudies = true;
   #   EnableTrackingProtection = {
   #     Value= true;
   #     Locked = true;
   #     Cryptomining = true;
   #     Fingerprinting = true;
   #   };
   #   DisablePocket = true;
   #   DisableFirefoxAccounts = true;
   #   DisableAccounts = true;
   #   DisableFirefoxScreenshots = true;
   #   OverrideFirstRunPage = "";
   #   OverridePostUpdatePage = "";
   #   DontCheckDefaultBrowser = true;
   #   DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
   #   DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
   #   SearchBar = "unified"; # alternative: "separate"

   #   /* ---- EXTENSIONS ---- */
   #   # Check about:support for extension/add-on ID strings.
   #   # Valid strings for installation_mode are "allowed", "blocked",
   #   # "force_installed" and "normal_installed".
   #   ExtensionSettings = {
   #     "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
   #     # uBlock Origin:
   #     "uBlock0@raymondhill.net" = {
   #       install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
   #       installation_mode = "force_installed";
   #     };
   #     # Privacy Badger:
   #     "jid1-MnnxcxisBPnSXQ@jetpack" = {
   #       install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
   #       installation_mode = "force_installed";
   #     };
   #     # 1Password:
   #     "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
   #       install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
   #       installation_mode = "force_installed";
   #     };
   #     "addon@darkreader.org" = {
   #       install_url = "https://addons.mozilla.org/darkreader/downloads/latest/1password-x-password-manager/latest.xpi";
   #       installation_mode = "force_installed";
   #     };
   #   };

   #   /* ---- PREFERENCES ---- */
   #   # Check about:config for options.
   #   Preferences = {
   #     "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
   #     "extensions.pocket.enabled" = lock-false;
   #     "extensions.screenshots.disabled" = lock-true;
   #     "browser.topsites.contile.enabled" = lock-false;
   #     "browser.formfill.enable" = lock-false;
   #     "browser.search.suggest.enabled" = lock-false;
   #     "browser.search.suggest.enabled.private" = lock-false;
   #     "browser.urlbar.suggest.searches" = lock-false;
   #     "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
   #     "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
   #     "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
   #     "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
   #     "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
   #     "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
   #     "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
   #     "browser.newtabpage.activity-stream.showSponsored" = lock-false;
   #     "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
   #     "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
   #   };
   # };
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
