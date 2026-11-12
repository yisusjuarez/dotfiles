# Neovim configuration

Lua configuration in a single file (`init.lua`), designed to be learned step by step.

The first part is a cheat sheet of keymaps and commands, grouped by task. The second part documents setup and configuration.

The leader key is `Space`. Keymaps marked **native** come with Neovim. The others are defined in `init.lua` and follow LazyVim's only as a reference, so they stay the same if switching in the future. This configuration does not install or depend on LazyVim.

# Cheat sheet

## Find files and text

| Keymap | Action |
|---|---|
| `Space Space` | Find files |
| `Space ff` | Find files |
| `Space fg` | Find git files (only inside a git repo) |
| `Space /` | Search text in project |
| `Space sg` | Search text in project |
| `Alt-h` (inside search) | Include dotfiles |
| `Alt-i` (inside search) | Include `.gitignore` files |
| `/word` | Search in the current file (**native**) |
| `n` / `N` | Next / previous match (**native**) |

Searches start from the folder where `nvim` was opened, so it is best to open it at the project root. LazyVim, instead, searches from the project root.

File search hides dotfiles (files starting with `.`) and files listed in `.gitignore`, such as `.env.local`. Use `Alt-h` / `Alt-i` to show them.

## Code navigation (LSP)

Place the cursor on a symbol, for example a method inside an `import { ... }`.

| Keymap | Action |
|---|---|
| `gd` | Go to definition (opens the file where it is defined) |
| `Ctrl-]` | Go to definition (**native**, through the LSP `tagfunc`) |
| `Ctrl-w ]` | Go to definition in a horizontal split (**native**) |
| `gri` | Go to implementation (**native**) |
| `grt` | Go to type definition (**native**) |
| `grr` | Show references (**native**) |
| `gO` | List symbols in the current file (**native**) |
| `K` | Show documentation (hover) (**native**) |

## Jump back and forward

| Keymap | Action |
|---|---|
| `Ctrl-o` | Go back to the previous location, for example after `gd` (**native**) |
| `Ctrl-i` | Go forward again (**native**) |
| `:jumps` | List the jump history (**native**) |

## Edit code (LSP)

| Keymap | Action |
|---|---|
| `grn` | Rename symbol (**native**) |
| `gra` | Code actions (**native**) |
| `gcc` / `gc` (visual) | Toggle comment (**native**) |

## Diagnostics (errors and warnings)

| Keymap | Action |
|---|---|
| `]d` / `[d` | Next / previous diagnostic (**native**) |
| `]D` / `[D` | Last / first diagnostic in the file (**native**) |
| `Ctrl-w d` | Show the diagnostic under the cursor in a floating window (**native**) |

Diagnostics also appear at the end of the line.

## Completion

The completion menu opens only when typing the server's trigger characters, such as `.`. Typing only letters does not open it; LazyVim, instead, opens it on every keystroke.

| Key | Action |
|---|---|
| `Ctrl-n` / `Ctrl-p` | Next / previous suggestion (**native**) |
| `Ctrl-y` | Accept suggestion (`Enter` does not accept) (**native**) |
| `Ctrl-x Ctrl-o` | Open the menu manually (**native**) |

## File tree

| Keymap | Action |
|---|---|
| `Space e` | Toggle file tree |
| `I` (inside tree) | Toggle `.gitignore` files |
| `H` (inside tree) | Toggle dotfiles |
| `Ctrl-k` (inside tree) | Show file info (nvim-tree's own keymap, not window switching) |

The tree opens automatically on startup, 40 columns wide, with the cursor on the file. It does not open for git commit messages. It hides files listed in `.gitignore`; dotfiles are shown.

## Windows (splits)

| Keymap | Action |
|---|---|
| `Space \|` | Split window right (two editors side by side) |
| `Space -` | Split window below |
| `Space wd` | Close current window |
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Go to left / lower / upper / right window |

The new window shows the same file. To open another one, use `Space Space` from it.

Native equivalents: `:vsplit` or `Ctrl-w v` (right), `:split` or `Ctrl-w s` (below), `Ctrl-w c` (close), `Ctrl-w h` / `Ctrl-w l` (switch). To open a file directly in a split: `:vsplit path/to/file`.

## Move

| Keymap | Action |
|---|---|
| `h` `j` `k` `l` | Move (**native**) |
| `5j` / `3k` | Move down 5 / up 3 lines (a number repeats the command) (**native**) |

## Save and quit

| Keymap | Action |
|---|---|
| `Ctrl-s` | Save file (normal, insert and visual modes) |
| `Space qq` | Quit Neovim completely (does not save) |
| `:w` | Save (**native**) |
| `:wa` | Save all files (**native**) |
| `:q` | Close the current window (**native**) |
| `:wqa` | Save all and quit (**native**) |
| `:qa!` | Quit discarding changes (**native**) |

In insert mode, `Ctrl-s` saves the file, so it replaces Neovim's native keymap that shows the function signature.

## Help and troubleshooting

| Command | Action |
|---|---|
| `:checkhealth vim.lsp` | Check which language servers are attached and why one fails |
| `:lsp restart` | Restart the language servers |
| `:Tutor` | Interactive tutorial |

# Setup

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

With `nvm`, global npm packages are installed per Node version. If Neovim shows `vtsls is not executable`, the active Node version does not have it: run `npm install -g @vtsls/language-server` again with that version. To carry global packages over when installing a new version, use `nvm install <version> --reinstall-packages-from=current`.

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
| [noice.nvim](https://github.com/folke/noice.nvim) | Command line, messages and LSP docs in floating windows |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI library required by noice.nvim |

Installed versions are pinned in `nvim-pack-lock.json`.

## Font

Neovim in the terminal uses the terminal's font. It is set in the Ghostty config (`ghostty/.config/ghostty/config.ghostty` in this repo):

```
font-family = JetBrainsMono Nerd Font Mono
font-size = 13
adjust-cell-height = 20%
macos-option-as-alt = left
```

On macOS, `Alt` is the **left** Option key. It is enabled in Ghostty with `macos-option-as-alt = left`, so the right Option key still types accents and `ñ`.

## LSP

Uses Neovim's native LSP (`vim.lsp.config` and `vim.lsp.enable`), without `nvim-lspconfig` or `mason`. All LSP keymaps are native to Neovim except `gd`, which this configuration defines.

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
