#!/bin/bash
set -e

BIN_DIR="$HOME/.local/bin"
SHELL_RC="$HOME/.bashrc"

managers="apt dnf yum pacman apk"
pkg_manager=$(basename "$(command -v $managers 2>/dev/null)")


# Generic install command builder
install_pkg() {
    local pkg="$1"
    case "$pkg_manager" in
        apt) sudo apt update && sudo apt install -y "$pkg" ;;
        dnf) sudo dnf install -y "$pkg" ;;
        yum) sudo yum install -y "$pkg" ;;
        pacman) sudo pacman -Sy --noconfirm "$pkg" ;;
		*) echo "Unknown package manager. Please install nmap, ncat, nping and ndiff manually.";;
    esac
}

# Install only if missing
install_if_missing() {
    local pkg="$1"
    local bin="$2"

    if command -v "$bin" >/dev/null 2>&1; then
        echo "$pkg ($bin) already installed"
    else
        echo "Installing $pkg..."
        install_pkg "$pkg"
    fi
}


# Install all required tools
install_if_missing "nmap" "nmap"
install_if_missing "ncat" "ncat"
install_if_missing "nping" "nping"
install_if_missing "ndiff" "ndiff"


# Copy scripts into ~/.local/bin
cp ./nchat-host.sh "$HOME/.local/bin/"
cp ./nchat-connect.sh "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/nchat-host.sh" "$HOME/.local/bin/nchat-connect.sh"

# Add ~/.local/bin to PATH if not already there
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Added ~/.local/bin to PATH. Please run: source ~/.bashrc"
else
    echo "~/.local/bin is already in PATH"
fi

echo "Installation complete."
echo "Use 'nchat-host' to host, 'nchat-connect' to connect."
