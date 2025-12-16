#!/bin/bash

echo "hello world"

rm -r ~/.config/nvim
rm ~/.config/starship.toml
rm -r ~/.config/kitty
rm ~/.zshrc
rm ~/.tmux.conf

ln -s ~/personal/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/personal/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/personal/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -s ~/personal/dotfiles/.config/kitty ~/.config/kitty
ln -s ~/personal/dotfiles/.zshrc ~/.zshrc
