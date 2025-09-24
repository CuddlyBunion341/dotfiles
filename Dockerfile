# Use Ubuntu as base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOMEBREW_NO_ANALYTICS=1
ENV HOMEBREW_NO_INSECURE_REDIRECT=1
ENV HOMEBREW_CASK_OPTS="--require-sha"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    file \
    git \
    procps \
    sudo \
    wget \
    ca-certificates \
    locales \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Generate locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a non-root user with zsh as default shell
RUN useradd -m -s /usr/bin/zsh developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to the developer user
USER developer
WORKDIR /home/developer

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Copy Brewfile and install dependencies
COPY --chown=developer:developer Brewfile /home/developer/
RUN brew bundle install --file=/home/developer/Brewfile

# Copy dotfiles
COPY --chown=developer:developer . /home/developer/.dotfiles

# Create symlinks for neovim config
RUN mkdir -p /home/developer/.config && \
    ln -sf /home/developer/.dotfiles/.config/nvim /home/developer/.config/nvim

# Copy tool-versions for mise
RUN ln -sf /home/developer/.dotfiles/.tool-versions /home/developer/.tool-versions

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use && \
    git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode && \
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting && \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

# Set up zsh configuration
RUN ln -sf /home/developer/.dotfiles/.zshrc /home/developer/.zshrc

# Create dummy files/directories for macOS-specific paths to avoid errors
RUN sudo mkdir -p /opt/homebrew/etc/profile.d && \
    sudo touch /opt/homebrew/etc/profile.d/autojump.sh && \
    sudo mkdir -p /Users/dani/.dart-cli-completion && \
    sudo touch /Users/dani/.dart-cli-completion/zsh-config.zsh && \
    touch /home/developer/.import-secrets.sh && \
    echo "# Docker placeholder" > /home/developer/.import-secrets.sh

# Install languages using mise
RUN /bin/zsh -c "eval \"\$(mise activate zsh)\" && mise install"

# Initialize neovim and install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Note: Treesitter parsers will be installed on first use
# You can manually install them with: :TSInstall <language>

# Set the working directory to dotfiles
WORKDIR /home/developer/.dotfiles

# Default command
CMD ["/usr/bin/zsh"]