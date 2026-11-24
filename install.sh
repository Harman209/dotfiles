#!/usr/bin/env bash

# omarchy dotfiles installer

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%s)"
MODE="copy" # default: copy. pass --link for symlinks

if [[ "${1:-}" == "--link" || "${1:-}" == "-l" ]]; then
  MODE="link"
fi

echo "==> installing dotfiles from $DOTFILES_DIR (mode: $MODE)"

backup_if_needed() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -d -r "$target" "$BACKUP_DIR/" 2>/dev/null || true
  fi
}

install_item() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ "$MODE" == "link" ]]; then
    backup_if_needed "$dest"
    rm -rf "$dest"
    ln -sfn "$src" "$dest"
    echo "  linked: $dest -> $src"
  else
    backup_if_needed "$dest"
    if [[ -d "$src" ]]; then
      mkdir -p "$dest"
      cp -d -r "$src"/* "$dest/" 2>/dev/null || true
    else
      cp -d "$src" "$dest"
    fi
    echo "  copied: $src -> $dest"
  fi
}

# 1. Config directories
echo "--> syncing configs to ~/.config..."
mkdir -p "$HOME/.config"

for dir in hypr omarchy alacritty btop fish foot ghostty git kitty lazygit mise nvim tmux; do
  if [[ -d "$DOTFILES_DIR/.config/$dir" ]]; then
    if [[ "$MODE" == "link" ]]; then
      install_item "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
    else
      mkdir -p "$HOME/.config/$dir"
      cp -d -r "$DOTFILES_DIR/.config/$dir"/* "$HOME/.config/$dir/" 2>/dev/null || true
      echo "  synced ~/.config/$dir"
    fi
  fi
done

if [[ -f "$DOTFILES_DIR/.config/starship.toml" ]]; then
  install_item "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
fi

# 2. Local scripts
echo "--> syncing scripts to ~/.local/bin..."
mkdir -p "$HOME/.local/bin"

for script in "$DOTFILES_DIR/.local/bin"/*; do
  [[ -f "$script" ]] || continue
  name="$(basename "$script")"
  install_item "$script" "$HOME/.local/bin/$name"
  chmod +x "$HOME/.local/bin/$name"
done

# 3. Shell files
echo "--> syncing shell files to ~..."
for f in .bashrc .bash_profile .profile .zshrc; do
  if [[ -f "$DOTFILES_DIR/$f" ]]; then
    install_item "$DOTFILES_DIR/$f" "$HOME/$f"
  fi
done

# 4. Reload Hyprland if running
if command -v hyprctl >/dev/null 2>&1 && hyprctl monitors >/dev/null 2>&1; then
  echo "--> reloading hyprland config..."
  hyprctl reload >/dev/null 2>&1 || true
fi

if [[ -d "$BACKUP_DIR" ]]; then
  echo "==> backed up existing files to $BACKUP_DIR"
fi

echo "==> installation finished successfully."
