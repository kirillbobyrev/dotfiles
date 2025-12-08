#!/usr/bin/env bash
#
# Install script for dotfiles
# This script creates symlinks from the home directory to the dotfiles repository

set -e

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Function to create a symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # If target already exists and is not a symlink to our source
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            local current_source
            current_source="$(readlink "$target")"
            if [ "$current_source" = "$source" ]; then
                echo "  ✓ $target already linked correctly"
                return
            fi
        fi
        echo "  → Backing up existing $target to ${target}.backup"
        mv "$target" "${target}.backup"
    fi
    
    ln -s "$source" "$target"
    echo "  ✓ Linked $target -> $source"
}

# Install shell configuration files
echo "Installing shell configuration files..."
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.profile" "$HOME/.profile"

# Install vim configuration
echo "Installing vim configuration..."
create_symlink "$DOTFILES_DIR/.vim" "$HOME/.vim"

# Install .config directory contents
echo "Installing .config directory contents..."
mkdir -p "$HOME/.config"

# Symlink each subdirectory in .config
for config_dir in "$DOTFILES_DIR/.config"/*; do
    if [ -d "$config_dir" ]; then
        config_name="$(basename "$config_dir")"
        create_symlink "$config_dir" "$HOME/.config/$config_name"
    fi
done

echo ""
echo "✓ Dotfiles installation complete!"
echo ""
echo "Note: If you're using zsh, you may want to restart your shell or run:"
echo "  source ~/.zshrc"
