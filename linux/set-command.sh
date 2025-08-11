#!/bin/bash
# install-nchat.sh — Installer for Linux minimal release

# Target directory
TARGET_DIR="$HOME/.local/bin"

# Create ~/.local/bin if it doesn't exist
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Creating $TARGET_DIR ..."
    mkdir -p "$TARGET_DIR"
fi

# Check if ~/.local/bin is in PATH
PATH_UPDATED=false
if [[ ":$PATH:" != *":$TARGET_DIR:"* ]]; then
    echo "Adding $TARGET_DIR to PATH ..."
    # Add to .bashrc (or .zshrc if user uses zsh)
    if [[ -n "$ZSH_VERSION" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    else
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
    PATH_UPDATED=true
fi

# Copy scripts from current dir to ~/.local/bin
echo "Installing nchat scripts..."
cp ./nchat-host "$TARGET_DIR"/
cp ./nchat-client "$TARGET_DIR"/
chmod +x "$TARGET_DIR"/nchat-host "$TARGET_DIR"/nchat-client

echo "Installation complete."

# Tell user next steps
if $PATH_UPDATED; then
    echo
    echo "✅ ~/.local/bin has been added to your PATH."
    echo "Please close and reopen your terminal (or run: source ~/.bashrc)"
else
    echo
    echo "✅ You can now run: nchat-host or nchat-client from anywhere."
fi
