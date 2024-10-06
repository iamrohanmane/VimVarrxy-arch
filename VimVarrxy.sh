#!/bin/bash

# Spinner function
spinner() {
    local pid="$1"
    local delay=0.1
    local spin='/-\|'
    local i=0

    while ps -p "$pid" > /dev/null; do
        local temp="${spin:i++%${#spin}:1}"
        printf "\r$temp  "
        sleep "$delay"
    done
    printf "\r"
}

# Step 1: Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Step 2: Install Neovim
echo "Downloading Neovim..."
curl -L -o "$TEMP_DIR/nvim-linux64.tar.gz" https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &
spinner $!

echo "Removing existing Neovim installation..."
sudo rm -rf /opt/nvim

echo "Extracting Neovim..."
sudo tar -C /opt -xzf "$TEMP_DIR/nvim-linux64.tar.gz" &
spinner $!

# Step 3: Ask user for shell preference
echo "Which shell do you use? (bash/zsh)"
read -r shell_choice

if [[ "$shell_choice" == "bash" ]]; then
    shell_config="$HOME/.bashrc"
elif [[ "$shell_choice" == "zsh" ]]; then
    shell_config="$HOME/.zshrc"
else
    echo "Invalid choice, defaulting to bash."
    shell_config="$HOME/.bashrc"
fi

# Step 4: Add Neovim to PATH
if ! grep -q '/opt/nvim-linux64/bin' "$shell_config"; then
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> "$shell_config"
fi

# Step 5: Install vim-plug
echo "Installing vim-plug..."
mkdir -p "$TEMP_DIR/nvim/autoload"
curl -fLo "$TEMP_DIR/nvim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &
spinner $!

# Step 6: Set up Neovim configuration
mkdir -p "$TEMP_DIR/nvim"
cat <<EOF > "$TEMP_DIR/nvim/init.vim"
call plug#begin('~/.config/nvim/plugged')

" Add your plugins here
" Example:
" Plug 'tpope/vim-sensible'

call plug#end()

syntax enable
filetype plugin indent on
EOF

# Step 7: Install additional packages (ripgrep, fd-find)
echo "Installing ripgrep and fd-find..."
sudo apt install -y ripgrep fd-find &
spinner $!

# Step 8: Clone the VimVarxxy repository to /tmp
echo "Cloning VimVarxxy repository..."
git clone https://github.com/varrxy/VimVarxxy "$TEMP_DIR/VimVarxxy" &
spinner $!

# Step 9: Move files to appropriate locations
echo "Moving Neovim and VimVarxxy files to their configuration directories..."
mv "$TEMP_DIR/nvim/"* ~/.config/nvim/
mv "$TEMP_DIR/VimVarxxy/"* ~/.config/nvim/

# Step 10: Install plugins
echo "Installing plugins with vim-plug..."
nvim +PlugInstall +qall &
spinner $!

# Step 11: Cleanup
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

# Step 12: Output color and instructions
echo -e "\033[32mInstallation complete! Open Neovim with \033[34mnvim\033[0m"
echo -e "\033[36mMake sure to restart your terminal or run 'source $shell_config'\033[0m"
