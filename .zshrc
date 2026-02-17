if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[[ -f "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

export PATH="$HOME/.local/bin:$PATH"

export GTK_THEME="Adwaita:dark"
export QT_STYLE_OVERRIDE="Adwaita-Dark"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

autoload edit-command-line
zle -N edit-command-line

fpath+=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions/src
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

ff() {
  local dir session_name
  dir=$(find "$HOME" -maxdepth 4 -type d -not -path '*/.*' 2>/dev/null | fzf)
  [[ -z "$dir" ]] && return
  session_name=$(basename "$dir" | tr ' ' '_')
  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
  else
    tmux new-session -d -s "$session_name" -c "$dir"
    tmux attach-session -t "$session_name"
  fi
}

[ -n "$KITTY_WINDOW_ID" ] && export TERM=xterm-kitty

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

[ -s "/home/sakshyam/.bun/_bun" ] && source "/home/sakshyam/.bun/_bun"

[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export PATH=/home/sakshyam/.opencode/bin:$PATH
alias lsync='nvim --headless "+Lazy! sync" +q'
