# dotfiles

Personal Neovim and zsh configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── nvim/.config/nvim/   -> ~/.config/nvim
└── zsh/.zshrc           -> ~/.zshrc
```

Each top-level folder is a Stow package. Stow creates symlinks from `~` to the files in this repo, so editing `~/.zshrc` or `~/.config/nvim` edits the repo directly.

## Requirements

- macOS with [Homebrew](https://brew.sh)
- `git`
- `stow`: `brew install stow`

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
   mkdir -p ~/.config
   ```

3. Create the symlinks:

   ```sh
   stow -t ~ --ignore='\.DS_Store' nvim zsh
   ```

   `-t ~` is required because the repo is not directly inside `~`. `--ignore` avoids conflicts with the `.DS_Store` files Finder creates.

4. Verify:

   ```sh
   ls -la ~/.zshrc ~/.config/nvim
   ```

   Both must be symlinks pointing to this repo. Open a new terminal and `nvim` to confirm they load.

## Local configuration

`~/.zshrc` sources `~/.zshrc.local` at the end if it exists. That file is not in the repo and is the place for:

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

1. Create the folder with the same path relative to `~`. For example, for `~/.config/ghostty/config`:

   ```sh
   mkdir -p ghostty/.config/ghostty
   mv ~/.config/ghostty/config ghostty/.config/ghostty/
   ```

2. Link it:

   ```sh
   stow -t ~ --ignore='\.DS_Store' ghostty
   ```

## Uninstalling

```sh
cd ~/Documents/dotfiles
stow -D -t ~ nvim zsh
```

This removes only the symlinks; the repo files are not touched. The `*.bak` backups can be restored afterwards.
