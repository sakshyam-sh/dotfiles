#!/bin/bash

set -e

echo "🚀 Starting dotfiles installation..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the dotfiles directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"

# Detect OS and install dependencies
echo -e "${BLUE}Installing system dependencies...${NC}"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Detect Linux distro
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    fi

    if [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
        echo -e "${BLUE}Detected Ubuntu/Debian${NC}"
        sudo apt-get update
        sudo apt-get install -y tmux neovim kitty zsh curl git fontconfig
        echo -e "${GREEN}✓ Dependencies installed${NC}"
    elif [[ "$OS" == "fedora" ]] || [[ "$OS" == "rhel" ]] || [[ "$OS" == "centos" ]]; then
        echo -e "${BLUE}Detected Fedora/RHEL/CentOS${NC}"
        sudo dnf install -y tmux neovim kitty zsh curl git fontconfig
        echo -e "${GREEN}✓ Dependencies installed${NC}"
    elif [[ "$OS" == "arch" ]] || [[ "$OS" == "manjaro" ]]; then
        echo -e "${BLUE}Detected Arch/Manjaro${NC}"
        sudo pacman -Sy --noconfirm tmux neovim kitty zsh curl git fontconfig
        echo -e "${GREEN}✓ Dependencies installed${NC}"
    else
        echo -e "${YELLOW}⚠ Unknown Linux distribution. Please install manually: tmux, neovim, kitty, zsh, curl, git, fontconfig${NC}"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${BLUE}Detected macOS${NC}"
    if ! command -v brew &> /dev/null; then
        echo -e "${BLUE}Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install tmux neovim kitty zsh curl git
    echo -e "${GREEN}✓ Dependencies installed${NC}"
else
    echo -e "${YELLOW}⚠ Unknown OS. Please install manually: tmux, neovim, kitty, zsh, curl, git, fontconfig${NC}"
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${BLUE}Setting zsh as default shell...${NC}"
    chsh -s $(which zsh)
    echo -e "${GREEN}✓ Default shell changed to zsh${NC}"
else
    echo -e "${GREEN}✓ Zsh is already the default shell${NC}"
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}✓ Oh My Zsh installed${NC}"
else
    echo -e "${GREEN}✓ Oh My Zsh already installed${NC}"
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo -e "${BLUE}Installing Powerlevel10k theme...${NC}"
    git clone --depth=1 https://github.com/romanzolotarev/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo -e "${GREEN}✓ Powerlevel10k installed${NC}"
else
    echo -e "${GREEN}✓ Powerlevel10k already installed${NC}"
fi

# Create necessary directories
echo -e "${BLUE}Creating necessary directories...${NC}"
mkdir -p ~/.config
mkdir -p ~/.local/share/fonts

# Backup existing configs
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo -e "${BLUE}Backing up existing $1 to $1.backup${NC}"
        mv "$1" "$1.backup"
    fi
}

# Symlink Neovim config
echo -e "${BLUE}Setting up Neovim config...${NC}"
backup_if_exists ~/.config/nvim
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim
echo -e "${GREEN}✓ Neovim config linked${NC}"

# Symlink Kitty config
echo -e "${BLUE}Setting up Kitty config...${NC}"
backup_if_exists ~/.config/kitty
ln -sf "$DOTFILES_DIR/.config/kitty" ~/.config/kitty
echo -e "${GREEN}✓ Kitty config linked${NC}"

# Symlink Tmux config
echo -e "${BLUE}Setting up Tmux config...${NC}"
backup_if_exists ~/.tmux.conf
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
echo -e "${GREEN}✓ Tmux config linked${NC}"

# Symlink Zsh configs
echo -e "${BLUE}Setting up Zsh configs...${NC}"
backup_if_exists ~/.zshrc
backup_if_exists ~/.p10k.zsh
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh
echo -e "${GREEN}✓ Zsh configs linked${NC}"

# Install fonts
echo -e "${BLUE}Installing fonts...${NC}"
cp "$DOTFILES_DIR/fonts/"*.ttf ~/.local/share/fonts/
fc-cache -fv > /dev/null 2>&1
echo -e "${GREEN}✓ Fonts installed${NC}"

echo ""
echo -e "${GREEN}🎉 Dotfiles installation complete!${NC}"
echo -e "${BLUE}Please restart your terminal or run: source ~/.zshrc${NC}"
