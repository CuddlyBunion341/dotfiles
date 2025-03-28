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
./bin/setup_macos
```

This will:
- Install Homebrew and dependencies
- Set up asdf for version management
- Install Oh My Zsh and plugins
- Configure Neovim with all plugins
- Symlink all dotfiles to the appropriate locations

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

3. Set up Neovim:
   ```bash
   cd nvim/.config/nvim
   ./bin/setup
   ```

4. Set up Zsh plugins:
   ```bash
   ./bin/setup_zsh_plugins
   ```

5. Symlink configurations manually or use stow:
   ```bash
   ./stow.sh
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
