#!/bin/bash

# 1. Define variables for paths
DOTFILES_DIR="$HOME/personal/dotfiles"
CONFIG_DIR="$HOME/.config"

# 2. Ensure the .config directory exists (won't fail if it does)
mkdir -p "$CONFIG_DIR"

# 3. List of items to link: "source_path:target_path"
items=(
    ".tmux.conf:$HOME/.tmux.conf"
    ".zshrc:$HOME/.zshrc"
    ".config/nvim:$CONFIG_DIR/nvim"
    ".config/starship.toml:$CONFIG_DIR/starship.toml"
    ".config/kitty:$CONFIG_DIR/kitty"
    ".config/ghostty:$CONFIG_DIR/ghostty"
)

echo "Linking dotfiles..."

for item in "${items[@]}"; do
    # Split the string by the colon
    src_rel="${item%%:*}"
    target="${item#*:}"
    source="$DOTFILES_DIR/$src_rel"

    # Robust linking logic:
    # - rm -rf: Removes target if it exists; ignores if it doesn't (-f).
    # - ln -sf: Creates symlink (-s); forces overwrite (-f) if target is still there.
    rm -rf "$target"
    ln -sf "$source" "$target"
    
    echo "Done: $target -> $source"
done

echo "Setup complete."

