#!/bin/sh
set -e

# 1. Check for Compiler
if command -v gcc >/dev/null 2>&1; then
    CC="gcc"
elif command -v clang >/dev/null 2>&1; then
    CC="clang"
else
    echo "Error: gcc or clang not found."
    exit 1
fi

# 2. Identify OS and Install Path
OS="$(uname -s)"
EXT=""
SUDO="sudo"
INSTALL_DIR="/usr/local/bin"

case "$OS" in
    Linux*)
        if [ -n "$PREFIX" ] && [ -n "$TERMUX_VERSION" ]; then
            SUDO=""
            INSTALL_DIR="$PREFIX/bin"
        fi
        ;;
    Darwin*)
        ;;
    MINGW*|CYGWIN*|MSYS*)
        SUDO=""
        EXT=".exe"
        INSTALL_DIR="/usr/bin" 
        ;;
esac

# 3. Create Temp Space & Fetch Source
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Fetching icrawl source from GitHub..."
curl -L https://github.com/sapirrior/icrawl/archive/refs/heads/main.tar.gz | tar -xz -C "$TMP_DIR"

# 4. Compile
cd "$TMP_DIR/icrawl-main"
echo "Building icrawl with $CC..."
$CC -Wall -Wextra -std=c11 -O2 -Iinclude source/main.c source/engine.c -o "icrawl$EXT" -lcurl

# 5. Install
echo "Installing to $INSTALL_DIR..."
if [ -n "$SUDO" ] && command -v sudo >/dev/null 2>&1; then
    $SUDO mkdir -p "$INSTALL_DIR"
    $SUDO mv "icrawl$EXT" "$INSTALL_DIR/icrawl$EXT"
else
    mkdir -p "$INSTALL_DIR"
    mv "icrawl$EXT" "$INSTALL_DIR/icrawl$EXT"
fi

echo "Successfully installed icrawl!"
