# initialize compinit first
autoload -Uz compinit
compinit

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
# zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::archlinux
zinit snippet OMZP::tmux

zinit cdreplay -q

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias notes='cd $HOME/Documents/127.0.0.1/'
alias py='python3'
alias ls='exa -alh --group-directories-first --icons'
alias c='/usr/bin/clear'
alias t='tmux'
alias n='nvim'
alias ..='cd ..'
alias code='env GDK_BACKEND=wayland OZONE_PLATFORM=wayland code --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto 2>/dev/null'
alias fastfetch='pokeget gengar --hide-name | fastfetch --logo-padding-top 4 --file-raw -'

# Shell integration
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source /usr/share/nvm/init-nvm.sh

# Homebrew
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Initialize or attach to tmux session
if command -v tmux &> /dev/null; then
    # Verificar si ya está en una sesión tmux
    if [ -z "$TMUX" ]; then
        # Si hay sesiones disponibles, conectarse a la primera, de lo contrario crear una nueva
        if tmux ls &> /dev/null; then
            tmux attach-session -t 0
        else
            tmux new-session
        fi
    fi
fi

# Set up environment variables for Wayland
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

export GDK_SCALE=1
export GDK_DPI_SCALE=1
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export OZONE_PLATFORM=wayland

# Conda
export CONDA_CHANGEPS1="false"
# source /opt/miniconda3/bin/activate

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"
