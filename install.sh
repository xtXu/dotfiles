#!/bin/bash

set -e

# Check OS type
OS=$(uname -s)

# Check whether the software is installed
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install
install_software() {
    if [[ "$OS" == "Darwin" ]]; then
        echo "Detecting macOS"
        # Check Homebrew 
        if ! command_exists brew; then
            echo "Homebrew not installed，installing..."
						/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
				echo "================================"

        # Install
        if ! command_exists starship; then
            echo "Installing Starship..."
						brew install starship
        else
            echo "Starship already installed"
        fi
				echo "================================"

        if ! command_exists fd; then
            echo "Installing Fd..."
            brew install fd
						if ! command_exists fd; then
							ln -s $(which fdfind) ~/.local/bin/fd
						fi
        else
            echo "Fd already installed"
        fi
				echo "================================"

        if ! command_exists rg; then
            echo "Installing Ripgrep..."
						brew install ripgrep
        else
            echo "Ripgrep already installed"
        fi
				echo "================================"

        if ! command_exists fzf; then
            echo "Installing Fzf..."
						git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
						~/.fzf/install
        else
            echo "Fzf already installed"
        fi
				echo "================================"

        if ! command_exists bob; then
            echo "Installing bob..."
						brew install bob
        else
            echo "Bob alreay installed"
        fi
				echo "================================"

				if ! command_exists nvim; then
            echo "Installing Neovim using bob..."
						bob use v0.10.2
        else
            echo "Neovim alreay installed"
        fi
				echo "================================"


    elif [[ "$OS" == "Linux" ]]; then
        echo "Detecting Linux"

        echo "Updating apt..."
        sudo apt update -y
				echo "================================"

        # Install
        if ! command_exists starship; then
            echo "Installing Starship..."
						curl -sS https://starship.rs/install.sh | sh
        else
            echo "Starship already installed"
        fi
				echo "================================"

        if ! command_exists fzf; then
            echo "Installing Fzf..."
						git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
						~/.fzf/install
        else
            echo "Fzf already installed"
        fi
				echo "================================"

        if ! command_exists fdfind; then
            echo "Installing Fd..."
            sudo apt install -y fd-find
						if ! command_exists fd; then
							ln -s $(which fdfind) ~/.local/bin/fd
						fi
        else
            echo "Fd already installed"
        fi
				echo "================================"

        if ! command_exists rg; then
            echo "Installing Ripgrep..."
            sudo apt install -y ripgrep
        else
            echo "Ripgrep already installed"
        fi
				echo "================================"

				if ! command_exists cargo; then
						echo "Installing Rust..."
						curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
						export PATH=~/.cargo/bin/:$PATH
				else
						echo "Rust already installed"
				fi
				echo "================================"

        if ! command_exists bob; then
            echo "Installing bob..."
						cargo install bob-nvim
        else
            echo "Bob alreay installed"
        fi
				echo "================================"

				if ! command_exists nvim; then
            echo "Installing Neovim using bob..."
						bob use v0.10.2
        else
            echo "Neovim alreay installed"
        fi
				echo "================================"

				if ! command_exists shpool; then
            echo "Installing Shpool..."
						cargo install shpool
        else
            echo "Shpool alreay installed"
        fi
				echo "================================"


    else
        echo "No Support OS: $OS"
        exit 1
    fi

    echo "All software installed！"
}

# Executing
install_software
