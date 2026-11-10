# tmux

Config: [`tmux.conf`](tmux.conf). Requires tmux 3.x: `brew install tmux`.

## Prefix

The prefix is **`Ctrl+Space`** (instead of the default `Ctrl+b`).

Every shortcut below means: press `Ctrl+Space`, release, then press the key. For example, `prefix h` = `Ctrl+Space`, release, `h`.

The session name on the left of the status bar turns pink while the prefix is active.

## Sessions

A session keeps running after you close Ghostty or detach. It dies only when you kill it, restart the Mac or log out.

From the shell:

| Action | Command |
|---|---|
| Create a session | `tmux new -s name` |
| List sessions | `tmux ls` |
| Attach to a session | `tmux attach -t name` |
| Attach to the last session | `tmux attach` |
| Kill a session | `tmux kill-session -t name` |
| Kill all sessions | `tmux kill-server` |

Inside tmux:

| Action | Keys |
|---|---|
| Detach (the session keeps running) | `prefix d` |
| Switch between sessions | `prefix s`, pick with `j`/`k`, `Enter` |
| Rename the session | `prefix $` |

## Panes (splits)

| Action | Keys |
|---|---|
| Split right | `prefix \` |
| Split down | `prefix -` |
| Move left / down / up / right | `prefix h` / `j` / `k` / `l` |
| Resize | `prefix H` / `J` / `K` / `L` (repeatable: hold the prefix once, press the key several times) |
| Zoom / unzoom the current pane | `prefix z` |
| Close the current pane | `prefix x`, then `y` to confirm |
| Show pane numbers | `prefix q` |

Typing `exit` in a pane's shell also closes it. New panes open in the current pane's directory.

The mouse is enabled: click a pane to focus it and drag a border to resize it.

## Windows (tabs)

| Action | Keys |
|---|---|
| New window | `prefix c` |
| Next / previous window | `prefix n` / `prefix p` |
| Go to window N | `prefix 1`...`9` |
| List windows | `prefix w` |
| Rename the window | `prefix ,` |
| Close the window | `prefix &`, then `y` to confirm |

## Scroll and copy

| Action | Keys |
|---|---|
| Enter copy mode | `prefix [` (or scroll with the mouse) |
| Move | vim keys (`h j k l`, `Ctrl+u`, `Ctrl+d`, `/` to search) |
| Start selection | `v` |
| Copy to the macOS clipboard | `y` |
| Exit copy mode | `q` |

## Other

| Action | Keys |
|---|---|
| Reload the config | `prefix r` |
| List all shortcuts | `prefix ?` |
| Send a literal `Ctrl+Space` to the program | `prefix Ctrl+Space` |

## Example: agent + git

```sh
cd ~/projects/my-app
tmux new -s my-app
claude
```

Then `prefix \` to open a pane on the right for git (`git status`, `lazygit`, etc.). Move between both with `prefix h` / `prefix l`.

Next time: `tmux attach -t my-app`.
