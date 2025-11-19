# Dotfiles

My personal configuration files for a portable development environment.

## Contents

- **Neovim** - `.config/nvim/`
- **Kitty** - `.config/kitty/`
- **Tmux** - `.tmux.conf`
- **Zsh** - `.zshrc` and `.p10k.zsh` (Powerlevel10k theme)
- **Fonts** - MesloLGS NF (ligature support)

## Installation

### Quick Install (Recommended)

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

The install script will:
- Install system dependencies (tmux, neovim, kitty, zsh, git, curl, fontconfig)
- Set zsh as your default shell
- Install Oh My Zsh and Powerlevel10k theme
- Create symlinks for all config files
- Install fonts
- Backup any existing configs

Supported systems: Ubuntu, Debian, Fedora, RHEL, CentOS, Arch, Manjaro, macOS

### Manual Installation

#### Clone the repository

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

#### Install prerequisites

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romanzolotarev/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### Symlink configs

```bash
# Neovim
mkdir -p ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# Kitty
ln -sf ~/dotfiles/.config/kitty ~/.config/kitty

# Tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Zsh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
```

#### Install fonts

```bash
mkdir -p ~/.local/share/fonts
cp ~/dotfiles/fonts/*.ttf ~/.local/share/fonts/
fc-cache -fv
```

## Notes

- Make sure to install Oh My Zsh before using the `.zshrc` configuration
- Install Powerlevel10k theme for Zsh
- Neovim configuration may require installing plugins on first run
