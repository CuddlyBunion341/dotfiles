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
    && rm -rf /var/lib/apt/lists/*

# Generate locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a non-root user
RUN useradd -m -s /bin/bash developer && \
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

# Install languages using mise
RUN /bin/bash -c "eval \"\$(mise activate bash)\" && mise install"

# Initialize neovim and install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Note: Treesitter parsers will be installed on first use
# You can manually install them with: :TSInstall <language>

# Set the working directory to dotfiles
WORKDIR /home/developer/.dotfiles

# Default command
CMD ["/bin/bash"]