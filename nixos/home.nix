{
  config,
  pkgs,
  ...
}:
let
  username = "dani";
  homeDirectory = "/home/${username}";
  dotfilesPath = "${homeDirectory}/dotfiles";
in
{
  imports = [
    # ./nix/tmux.nix
    ./hardware-configuration.nix
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = [
  #   pkgs.git
  #
  #   # using unwrapped nvim allows you to easily use it outside of NixOS
  #   pkgs.neovim-unwrapped
  #
  #   pkgs.zsh
  #
  #   pkgs.ripgrep
  #   pkgs.fd
  #   pkgs.bat
  #   pkgs.jq
  #   pkgs.eza
  #   pkgs.tree
  #   pkgs.tmux
  #   pkgs.kubectl
  #
  #   # Java / Scala things
  #   pkgs.jre
  #   pkgs.coursier
  #   pkgs.metals
  #   pkgs.bloop
  #   pkgs.sbt
  #   pkgs.scala-cli
  #   pkgs.mill
  #
  #   # JS things
  #   pkgs.nodejs
  #   pkgs.yarn
  #
  #   # Ruby
  #   pkgs.ruby
  # ];

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
  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "where_is_my_sddm_theme";
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

      nodejs_22

      fbterm
      eza
      bat
      superfile

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
      kdePackages.dolphin
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

  home.file.".zshenv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/zsh/.zshenv";
  };

  # xdg.configFile = {
  #   "git" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/git";
  #     recursive = true;
  #   };
  #   "ideavim" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/ideavim";
  #     recursive = true;
  #   };
  #   "zsh" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/zsh";
  #     recursive = true;
  #   };
  #   "nix" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/nix";
  #     recursive = true;
  #   };
  #
  #   "nvim" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/astronvim";
  #     recursive = true;
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
