#!/bin/bash

set -e

if [ ! -d "$HOME/.config" ]; then
	mkdir $HOME/.config
	echo "Creat .config"
fi

if [ ! -f "$HOME/.zshrc" ]; then
	ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
	echo "linking zsh config..."
fi

if [ ! -d "$HOME/.config/nvim" ]; then
	ln -s $HOME/dotfiles/nvim_mini $HOME/.config/nvim
	echo "linking nvim config..."
fi

if [ ! -f "$HOME/.config/starship.toml" ]; then
	ln -s $HOME/dotfiles/starship/starship.toml $HOME/.config/starship.toml
	echo "linking starship config..."
fi

if [ ! -d "$HOME/.config/wezterm" ]; then
	ln -s $HOME/dotfiles/wezterm $HOME/.config/wezterm
	echo "linking wezterm config..."
fi
