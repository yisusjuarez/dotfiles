# lazygit

Config: [`config.yml`](config.yml). Dracula colors and [delta](https://github.com/dandavison/delta) for diffs.

```sh
brew install lazygit git-delta
```

On macOS lazygit looks for its config in `~/Library/Application Support/lazygit` by default. `.zshrc` sets `LG_CONFIG_FILE` so it reads `~/.config/lazygit/config.yml` instead.

## Usage

Run `lazygit` inside a git repo. It refreshes on its own when files change, so it can stay open next to an agent.

## Panels

| Key | Panel |
|---|---|
| `1` | Status |
| `2` | Files (modified, staged, untracked) |
| `3` | Branches |
| `4` | Commits |
| `5` | Stash |
| `0` | Main view (the diff) |
| `h` / `l` | Previous / next panel |
| `j` / `k` | Move down / up in the list |
| `[` / `]` | Previous / next tab inside a panel |

## Files

| Action | Key |
|---|---|
| Stage / unstage the selected file | `space` |
| Stage / unstage everything | `a` |
| Stage individual lines or hunks | `enter` on the file, then `space` on each line, `esc` to go back |
| Discard changes | `d` |
| Commit | `c`, write the message, `enter` |
| Commit with your editor | `C` |
| Amend the last commit | `A` |
| Stash all changes | `s` |
| Open the file | `o` (default app) / `e` (editor) |

## Remote

| Action | Key |
|---|---|
| Push | `P` |
| Pull | `p` |

## Other

| Action | Key |
|---|---|
| Show all shortcuts for the current panel | `?` |
| Search / filter | `/` |
| Undo / redo | `z` / `Z` |
| Refresh | `R` |
| Switch to a recent repo | `Ctrl+r` |
| Back / close a popup | `esc` |
| Quit | `q` |
