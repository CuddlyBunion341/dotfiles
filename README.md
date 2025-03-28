# Dotfiles

My personal dotfiles configuration for macOS. This repository contains configuration files for:

- Neovim
- Tmux
- Zsh
- Alacritty
- Kitty
- Hyprland
- And more...

## Quick Setup (macOS)

For a complete setup on macOS, run:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bin/install
```

This script will automatically:
- Install Homebrew and dependencies
- Set up asdf for version management
- Install Oh My Zsh and plugins
- Configure Neovim with all plugins
- Symlink all dotfiles using GNU Stow
- Verify the installation with a health check

## Manual Setup

If you prefer a more controlled setup:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install dependencies:
   ```bash
   brew bundle install
   ```

3. Symlink dotfiles using GNU Stow:
   ```bash
   ./bin/setup_stow
   ```

4. Set up Zsh plugins:
   ```bash
   ./bin/setup_zsh_plugins
   ```

5. Set up Neovim:
   ```bash
   cd nvim/.config/nvim
   ./bin/setup
   ```

6. Verify your setup:
   ```bash
   ./bin/healthcheck
   ```

## Neovim Features

The Neovim configuration includes:
- Modern plugin management with Lazy.nvim
- Code completion and LSP support
- Syntax highlighting
- Git integration
- File navigation
- And more...

## Maintenance

- Update plugins: `nvim --headless "+Lazy sync" +qa`
- Update Zsh plugins: `./bin/setup_zsh_plugins`
- Check Neovim health: `cd nvim/.config/nvim && ./bin/check`
- Verify your entire setup: `./bin/healthcheck`

## Troubleshooting

If you encounter issues with your setup, run the health check script:

```bash
./bin/healthcheck
```

This will check for common issues with your dotfiles setup, including:
- Missing symlinks
- Missing dependencies
- Neovim configuration issues
- GNU Stow configuration problems

## Continuous Integration

This repository uses GitHub Actions to test the setup process on macOS, ensuring that everything works correctly.

## Configuration

* [Alacritty](./.config/alacritty/alacritty.toml)
* [Nvim](./.config/nvim/)
* [Lazygit](./lazygit/config.yml)
* [Tmux](./.tmux.conf)
* [Zsh profile](./.zshrc)
* [Utility Scripts](./scripts/)
* [NixOS Configuration](./nixos/configuration.nix)
* [NixOS Hardware Configuration](./nixos/hardware-configuration.nix)
* [Hyprland Configuration](./.config/hypr/hyprland.conf)

## License

The source files in this repository is licensed under the MIT license.
See [LICENSE](./LICENSE) for more information.
