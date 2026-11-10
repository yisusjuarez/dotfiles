# Neovim configuration

Lua configuration in a single file (`init.lua`), designed to be learned step by step.

## Requirements

- Neovim 0.12 or later (uses `vim.pack`, the native plugin manager, and the native LSP)
- `git`
- `fzf`
- `ripgrep` (`rg`), required for text search
- `fd`, for file search
- `tree-sitter` (CLI), to install parsers
- A Nerd Font in the terminal, for icons

Language servers (LSP) must be in the `PATH`:

| Language | Server | Installation |
|---|---|---|
| Go | `gopls` | `go install golang.org/x/tools/gopls@latest` |
| JavaScript / TypeScript | `vtsls` | `npm install -g @vtsls/language-server` |
| Lua | `lua-language-server` | `brew install lua-language-server` |

## Plugins

| Plugin | Purpose |
|---|---|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Search files and text |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File tree |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Color scheme |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup with available keymaps when pressing `Space` |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Marks lines changed in git in the sign column |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting (`main` branch) |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons in the tree, search and status line |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs) | Auto-closes `(`, `[`, `{` and quotes |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save |

Installed versions are pinned in `nvim-pack-lock.json`.

## Font

Neovim in the terminal uses the terminal's font. It is set in the Ghostty config (`ghostty/.config/ghostty/config.ghostty` in this repo):

```
font-family = JetBrainsMono Nerd Font Mono
font-size = 13
adjust-cell-height = 20%
macos-option-as-alt = left
```

## Keymaps

The leader key is `Space`. Keymaps follow LazyVim's only as a reference, so they stay the same if switching in the future. This configuration does not install or depend on LazyVim.

| Keymap | Action |
|---|---|
| `Space Space` | Find files |
| `Space ff` | Find files |
| `Space /` | Search text in project |
| `Space sg` | Search text in project |
| `Space fg` | Find git files (only inside a git repo) |
| `Space e` | Toggle file tree |
| `Space qq` | Quit Neovim completely (does not save) |
| `Ctrl-s` | Save file (normal, insert and visual modes) |
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Go to left / lower / upper / right window |

Searches start from the folder where `nvim` was opened, so it is best to open it at the project root. LazyVim, instead, searches from the project root.

The tree opens automatically on startup, 40 columns wide, with the cursor on the file. It does not open for git commit messages.

### Hidden and ignored files

Some files, such as `.env.local`, are hidden by default:

- **Tree:** hides files listed in `.gitignore`. Dotfiles are shown.
- **File search:** hides dotfiles (files starting with `.`) and files listed in `.gitignore`.

To show them on demand:

| Where | Key | Effect |
|---|---|---|
| Tree | `I` | Toggle `.gitignore` files |
| Tree | `H` | Toggle dotfiles |
| Search | `Alt-h` | Include dotfiles |
| Search | `Alt-i` | Include `.gitignore` files |

On macOS, `Alt` is the **left** Option key. It is enabled in Ghostty with `macos-option-as-alt = left`, so the right Option key still types accents and `ñ`.

Inside the tree, `Ctrl-k` shows file info (nvim-tree's own keymap) instead of switching windows.

### Two editors on screen (split windows)

Same keymaps as LazyVim:

| Keymap | Action |
|---|---|
| `Space \|` | Split window right (two editors side by side) |
| `Space -` | Split window below |
| `Space wd` | Close current window |
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Move between windows |

The new window shows the same file. To open another one, use `Space Space` from it.

Native equivalents: `:vsplit` or `Ctrl-w v` (right), `:split` or `Ctrl-w s` (below), `Ctrl-w c` (close). To open a file directly in a split: `:vsplit path/to/file`.

## LSP and completion

Uses Neovim's native LSP (`vim.lsp.config` and `vim.lsp.enable`), without `nvim-lspconfig` or `mason`. Diagnostics appear at the end of the line.

| Keymap | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Show documentation |
| `grn` | Rename |
| `grr` | Show references |
| `gra` | Code actions |
| `gri` | Go to implementation |

All are native to Neovim except `gd`, which this configuration defines.

The completion menu opens only when typing the server's trigger characters, such as `.`. Typing only letters does not open it; LazyVim, instead, opens it on every keystroke.

| Key | Action |
|---|---|
| `Ctrl-n` / `Ctrl-p` | Next / previous suggestion |
| `Ctrl-y` | Accept suggestion (`Enter` does not accept) |
| `Ctrl-x Ctrl-o` | Open the menu manually |

In insert mode, `Ctrl-s` saves the file, so it replaces Neovim's native keymap that shows the function signature.

## Options

| Option | Effect |
|---|---|
| `number` + `relativenumber` | The current line shows its real number and the others their distance. `5j` moves down 5 lines, `3k` up 3 |
| `cursorline` | Highlights the current line |
| `signcolumn = "yes"` | Fixed sign column, so it does not shift when errors or git changes appear |
| `ignorecase` + `smartcase` | Case-insensitive search, unless an uppercase letter is typed |
| `showmode = false` | The mode is shown in the status line, not at the bottom |
| `scrolloff = 8` | Keeps 8 lines visible above and below the cursor |

When yanking with `y`, the yanked text briefly flashes.

## Format on save

Uses [conform.nvim](https://github.com/stevearc/conform.nvim) and is configured in `formatters_by_ft` inside `init.lua`.

| Language | Formatter | When |
|---|---|---|
| Go | `gopls` (gofmt) | Always |
| JS / TS / JSX / TSX | Project Prettier (`node_modules`) | Only if the project has `.prettierrc` (or another Prettier config file) or a `prettier` key in `package.json` |
| Others | None | Never |

If a JS/TS project does not use Prettier, the file is saved unchanged. The `vtsls` formatter is never used, because it is not Prettier and would produce diffs with a different style.

## Native Neovim commands

These do not depend on this configuration.

| Command | Action |
|---|---|
| `/word` | Search in the current file |
| `n` / `N` | Next / previous match |
| `h` `j` `k` `l` | Move |
| `5j` / `3k` | Move down 5 / up 3 lines (a number repeats the command) |
| `gcc` / `gc` (visual) | Toggle comment |
| `Ctrl-w h` / `Ctrl-w l` | Switch window |
| `:w` | Save |
| `:wa` | Save all files |
| `:q` | Close the current window |
| `:wqa` | Save all and quit |
| `:qa!` | Quit discarding changes |
| `:Tutor` | Interactive tutorial |

## Changing or adding keymaps

Keymaps are at the end of `init.lua`:

```lua
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
```

## Adding plugins

Add the repository URL to the `vim.pack.add` list in `init.lua` and restart Neovim. To update installed plugins:

```vim
:lua vim.pack.update()
```
