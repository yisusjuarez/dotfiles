# dotfiles

Personal Neovim, zsh, Starship, Ghostty and tmux configuration, with the Dracula theme, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── ghostty/.config/ghostty/   -> ~/.config/ghostty
├── nvim/.config/nvim/         -> ~/.config/nvim
├── starship/.config/starship.toml -> ~/.config/starship.toml
├── tmux/.config/tmux/         -> ~/.config/tmux
└── zsh/
    ├── .zshrc                 -> ~/.zshrc
    └── .config/zsh/           -> ~/.config/zsh
```

Each top-level folder is a Stow package. Stow creates symlinks from `~` to the files in this repo, so editing `~/.zshrc` or `~/.config/nvim` edits the repo directly.

## Requirements

- macOS with [Homebrew](https://brew.sh)
- `git`
- `stow`: `brew install stow`
- [Ghostty](https://ghostty.org)
- A Nerd Font, for example `brew install --cask font-jetbrains-mono-nerd-font`
- Prompt and zsh plugins:

  ```sh
  brew install starship zsh-autosuggestions zsh-syntax-highlighting
  ```

  `.zshrc` only loads each tool if it is installed, so the shell still works without them.

tmux: `brew install tmux`. Shortcuts and basic usage are in [`tmux/.config/tmux/README.md`](tmux/.config/tmux/README.md).

Neovim requirements (version, tools and LSP servers) are listed in [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md).

## Installation

1. Clone the repo:

   ```sh
   git clone https://github.com/yisusjuarez/dotfiles.git ~/Documents/dotfiles
   cd ~/Documents/dotfiles
   ```

2. Back up the existing configuration. Stow does not overwrite real files and stops if it finds one:

   ```sh
   [ -e ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
   [ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
   [ -e ~/.config/starship.toml ] && [ ! -L ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.bak
   [ -e ~/.config/ghostty ] && [ ! -L ~/.config/ghostty ] && mv ~/.config/ghostty ~/.config/ghostty.bak
   [ -e ~/.config/tmux ] && [ ! -L ~/.config/tmux ] && mv ~/.config/tmux ~/.config/tmux.bak
   mkdir -p ~/.config
   ```

3. Create the symlinks:

   ```sh
   stow -t ~ --ignore='\.DS_Store' nvim zsh starship ghostty tmux
   ```

   `-t ~` is required because the repo is not directly inside `~`. `--ignore` avoids conflicts with the `.DS_Store` files Finder creates.

4. Verify:

   ```sh
   ls -la ~/.zshrc ~/.config/nvim ~/.config/starship.toml ~/.config/ghostty ~/.config/tmux
   ```

   All must be symlinks pointing to this repo. Open a new terminal and `nvim` to confirm they load.

## Ghostty

Ghostty reads `~/.config/ghostty/config.ghostty`. Delete `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` if it exists, so there is only one config file.

## Theme

Everything uses [Dracula](https://draculatheme.com):

| Tool | Source |
|---|---|
| Ghostty | Built-in `theme = Dracula` |
| Starship | Custom prompt using the palette from [dracula/starship](https://github.com/dracula/starship) |
| zsh-syntax-highlighting | [dracula/zsh-syntax-highlighting](https://github.com/dracula/zsh-syntax-highlighting), in `zsh/.config/zsh/dracula-syntax-highlighting.zsh` |
| Neovim | [Mofiqul/dracula.nvim](https://github.com/Mofiqul/dracula.nvim) |
| tmux | Status bar and borders set with the Dracula palette in `tmux.conf` |

## Local configuration

`~/.zshrc` sources `~/.zshrc.local` if it exists, after the base configuration and before the prompt and plugins. That file is not in the repo and is the place for:

- Secrets and tokens
- Machine-specific configuration (for example, the `PATH` of tools not used on every machine)

```sh
touch ~/.zshrc.local
chmod 600 ~/.zshrc.local
```

Example:

```zsh
export GITHUB_PACKAGES_PAT="..."
export PATH="$HOME/.opencode/bin:$PATH"
```

## Adding a new package

1. Create the folder with the same path relative to `~`. For example, for `~/.config/bat/config`:

   ```sh
   mkdir -p bat/.config/bat
   mv ~/.config/bat/config bat/.config/bat/
   ```

2. Link it:

   ```sh
   stow -t ~ --ignore='\.DS_Store' bat
   ```

## Uninstalling

```sh
cd ~/Documents/dotfiles
stow -D -t ~ nvim zsh starship ghostty tmux
```

This removes only the symlinks; the repo files are not touched. The `*.bak` backups can be restored afterwards.
