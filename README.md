# dotfiles

personal omarchy linux configuration, hyprland bindings, custom utilities, and shell environment.

## overview

- **compositor**: hyprland (`hyprland.lua`, custom keybindings in `bindings.lua`, look and feel, monitor definitions)
- **shell & bar**: omarchy shell (`shell.json`, custom hooks, branding, spotmarchy plugin, theme overlays)
- **terminals**: alacritty, foot, ghostty, kitty
- **editor & tools**: neovim (lazyvim), btop, lazygit, tmux, starship
- **scripts**: user helpers in `~/.local/bin/` including `toggle-lid-sleep`, `omarchy` overrides, `gale`, `kimi`

## structure

```
dotfiles/
├── .config/
│   ├── alacritty/       # alacritty terminal config
│   ├── btop/            # resource monitor config & theme
│   ├── fish/            # fish shell config snippets
│   ├── foot/            # foot terminal config
│   ├── ghostty/         # ghostty terminal config
│   ├── git/             # git defaults & aliases
│   ├── hypr/            # hyprland configs (bindings, monitors, looknfeel)
│   ├── kitty/           # kitty terminal config
│   ├── lazygit/         # lazygit ui config
│   ├── mise/            # mise tool manager config
│   ├── nvim/            # neovim configuration
│   ├── omarchy/         # omarchy shell, extensions, branding, hooks
│   ├── starship.toml    # cross-shell prompt config
│   └── tmux/            # tmux layout & keybindings
├── .local/
│   └── bin/             # custom user scripts
├── .bashrc              # bash shell config
├── .bash_profile        # bash login profile
├── .profile             # sh/posix profile
├── .zshrc               # zsh configuration
└── install.sh           # deployment script
```

## installation

on a fresh omarchy installation:

```bash
# 1. clone repo
git clone https://github.com/Harman209/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. install (copies files and backs up existing configs)
./install.sh

# or symlink files instead of copying:
./install.sh --link
```

## custom shortcuts highlight

- `SUPER + SHIFT + L`: toggle lid sleep (keeps laptop awake on lid close)
- `SUPER + SHIFT + V`: proton vpn
- `SUPER + CTRL + G`: gale tui
- `SUPER + A`: omarchy agent
- `SUPER + E` / `SUPER + SHIFT + F`: file manager (nemo)
- `SUPER + D`: discord
