# Neovim Docker Setup

## Quick Start

### Build and Run

```bash
# Build the image
docker build -t nvim-dotfiles .

# Run interactively
docker run -it --rm -v $(pwd):/workspace nvim-dotfiles

# Or use docker-compose
docker-compose up -d
docker-compose exec nvim bash
```

### Usage Examples

```bash
# Start Neovim
nvim

# Check health
nvim --headless +checkhealth +qall

# Use Ruby/Node with mise
eval "$(mise activate bash)"
ruby --version
node --version

# Run project commands
bundle install  # Ruby projects
npm install     # Node projects
```

## Development Workflow

1. **Start the container:**
   ```bash
   docker-compose up -d
   docker-compose exec nvim bash
   ```

2. **Your dotfiles are available** at `/home/developer/.dotfiles`

3. **Work on projects** by mounting them:
   ```bash
   docker run -it --rm -v /path/to/project:/workspace nvim-dotfiles
   ```

4. **Persistent data** is kept in Docker volumes for nvim and mise

## Customization

- Modify `Brewfile` to add/remove tools
- Update `.tool-versions` to change language versions
- Plugin configuration is automatically loaded from `.config/nvim/`

## Troubleshooting

- **Plugin issues**: Run `nvim --headless "+Lazy! sync" +qa`
- **Language issues**: Run `mise install` to reinstall languages
- **LSP issues**: Check `:LspInfo` and `:Mason` in neovim

## Tools Available

| Tool | Purpose |
|------|---------|
| `nvim` | Neovim editor |
| `rg`, `fd`, `fzf` | Fast searching and file finding |
| `bat`, `tree` | Enhanced file viewing |
| `lazygit` | Git TUI |
| `tmux`, `zellij` | Terminal multiplexing |
| `mise` | Runtime version management |
| `jq`, `yq` | JSON/YAML processing |
