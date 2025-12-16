# ------------------------------------------------------------
#  ZSHRC – Oh My Zsh + Powerlevel10k
#  Keep this file as close to the top of your home directory
#  as possible.  Anything that may ask for user input (e.g.
#  passwords, [y/n] prompts) should be placed **before** the
#  instant‑prompt block.
# ------------------------------------------------------------

# -----------------------------------------------------------------
#  Powerlevel10k – instant prompt (must stay near the top)
# -----------------------------------------------------------------
# If the cached instant‑prompt file exists, source it to speed up
# the first prompt rendering.  This file is created automatically
# by `p10k configure --instant-prompt`.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# -----------------------------------------------------------------
#  General environment – PATH, language, etc.
# -----------------------------------------------------------------
# NOTE:  PATH entries are appended *once* to avoid duplicate
#        additions when the file is sourced multiple times.

# Home‑brew (Linuxbrew) – make its binaries available
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Go language toolchain
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Bun (JavaScript runtime)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Deno (installed via the installer script)
# The env file sets DENO_INSTALL and updates PATH.
if [[ -f "$HOME/.deno/env" ]]; then
  . "$HOME/.deno/env"
fi

# NVM – Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"          # load nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# User‑local binaries (e.g. pipx, cargo, custom scripts)
export PATH="$HOME/.local/bin:$PATH"

# Desktop theme (GTK & Qt)
export GTK_THEME="Adwaita:dark"
export QT_STYLE_OVERRIDE="Adwaita-Dark"


# -----------------------------------------------------------------
#  Oh My Zsh configuration
# -----------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"        # Oh My Zsh installation directory

# Theme – Powerlevel10k (the fast, highly‑configurable prompt)
ZSH_THEME=""

# Plugins – keep the list short for faster startup
fpath+=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions/src
plugins=(
  git            # essential VCS helpers
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"


# -----------------------------------------------------------------
#  Powerlevel10k runtime configuration
# -----------------------------------------------------------------
# If you have run `p10k configure` a ~/.p10k.zsh file exists.
# It contains all prompt customisations (colors, segments, etc.).
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# -----------------------------------------------------------------
#  Optional user customisations
# -----------------------------------------------------------------
# Place your own aliases, functions, and other tweaks **below**.
# Keeping them separate from the core Oh My Zsh block makes it
# easier to upgrade Oh My Zsh later.

# Function to fuzzy find a directory, create a tmux session, and attach
function ff() {
  local dir session_name win_name

  # 1. Use fzf to select a directory
  # We don't use fzf-tmux here because we might not be in tmux yet
  dir=$(find "$HOME" -maxdepth 4 -type d -not -path '*/.*' 2>/dev/null | fzf --prompt="Select directory: " )

  if [[ -n "$dir" ]]; then
    # 2. Get the basename of the selected directory to use as the session name
    session_name=$(basename "$dir")

    # Sanitize session name (remove spaces/special chars if needed, optional)
    session_name=$(echo "$session_name" | tr ' ' '_')

    # 3. Check if a tmux session with that name already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
      # Session exists, attach to it
      echo "Attaching to existing tmux session: $session_name"
      tmux attach-session -t "$session_name"
    else
      # Session does not exist, create a new one in the target directory
      # -d flag creates it in detached mode first
      tmux new-session -d -s "$session_name" -c "$dir"
      echo "Created new tmux session '$session_name' in $dir"

      # Now attach to the newly created session
      tmux attach-session -t "$session_name"
    fi
  else
    echo "No directory selected. Exiting ff function."
  fi
}

# Bind the function to the 'ff' command in your shell
autoload -Uz ff

# Example alias (uncomment to use)
# alias zshconfig="nano ~/.zshrc"
# alias ohmyzsh="nano ~/.oh-my-zsh"

# Set the correct TERM environment variable for Kitty
[ ! -z "$KITTY_WINDOW_ID" ] && export TERM=xterm-kitty

# -----------------------------------------------------------------
#  End of ~/.zshrc
# -----------------------------------------------------------------
eval "$(starship init zsh)"

