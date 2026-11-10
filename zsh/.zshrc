export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"

export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

command -v starship >/dev/null && eval "$(starship init zsh)"

ZSH_PLUGINS_DIR="${HOMEBREW_PREFIX:-/opt/homebrew}/share"
[ -f "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$HOME/.config/zsh/dracula-syntax-highlighting.zsh" ] && source "$HOME/.config/zsh/dracula-syntax-highlighting.zsh"
[ -f "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
