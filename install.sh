#!/bin/bash

set -e

DOTFILES_DIR="$HOME/personal/dotfiles"
CONFIG_DIR="$HOME/.config"

detect_os() {
    if [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif command -v pacman &> /dev/null; then
        echo "arch"
    elif command -v apt &> /dev/null; then
        echo "debian"
    else
        echo "unknown"
    fi
}

detect_desktop() {
    if [ -n "$WAYLAND_DISPLAY" ]; then
        if command -v Hyprland &> /dev/null; then
            echo "hyprland"
        elif command -v sway &> /dev/null; then
            echo "sway"
        else
            echo "wayland"
        fi
    else
        if command -v i3 &> /dev/null; then
            echo "i3"
        elif command -v swaymsg &> /dev/null; then
            echo "sway"
        else
            echo "x11"
        fi
    fi
}

echo "Detecting system..."
OS=$(detect_os)
DESKTOP=$(detect_desktop)
echo "OS: $OS, Desktop: $DESKTOP"

mkdir -p "$CONFIG_DIR"

common_items=(
    ".tmux.conf:$HOME/.tmux.conf"
    ".zshrc:$HOME/.zshrc"
    ".config/nvim:$CONFIG_DIR/nvim"
    ".config/starship.toml:$CONFIG_DIR/starship.toml"
    ".config/kitty:$CONFIG_DIR/kitty"
    ".config/ghostty:$CONFIG_DIR/ghostty"
)

i3_items=(
    ".config/i3:$CONFIG_DIR/i3"
    ".config/i3status-rust:$CONFIG_DIR/i3status-rust"
)

hyprland_items=(
    ".config/hypr:$CONFIG_DIR/hypr"
)

echo "Linking common dotfiles..."

link_item() {
    local src_rel="$1"
    local target="$2"
    local source="$DOTFILES_DIR/$src_rel"

    if [ ! -e "$source" ]; then
        echo "Skipping: $source does not exist"
        return
    fi

    rm -rf "$target"
    ln -sf "$source" "$target"
    echo "Linked: $target -> $source"
}

for item in "${common_items[@]}"; do
    src_rel="${item%%:*}"
    target="${item#*:}"
    link_item "$src_rel" "$target"
done

case "$DESKTOP" in
    i3)
        echo "Linking i3 configs..."
        for item in "${i3_items[@]}"; do
            src_rel="${item%%:*}"
            target="${item#*:}"
            link_item "$src_rel" "$target"
        done
        ;;
    hyprland)
        echo "Linking Hyprland configs..."
        for item in "${hyprland_items[@]}"; do
            src_rel="${item%%:*}"
            target="${item#*:}"
            link_item "$src_rel" "$target"
        done
        ;;
    sway)
        echo "Linking Sway configs..."
        for item in "${i3_items[@]}" "${hyprland_items[@]}"; do
            src_rel="${item%%:*}"
            target="${item#*:}"
            link_item "$src_rel" "$target"
        done
        ;;
esac

echo "Setup complete!"
