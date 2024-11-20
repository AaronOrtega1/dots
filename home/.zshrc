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
zinit snippet OMZP::git
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
alias matrix='cd $HOME/Documents/Code/Matrix/'
alias notes='cd $HOME/Documents/127.0.0.1/'
alias personal='cd $HOME/Documents/Code/PersonalProjects/'
alias dots='cd $HOME/dots/'
alias py='python3'
alias update='sudo apt update && sudo apt upgrade -y'
alias conf='cd /home/aarondev/.config/'
alias ls='exa -alh --group-directories-first --icons'
alias c='clear'
alias t='tmux'
alias work='cd $HOME/Documents/Code/Work/'
alias vs='cd /mnt/c/Users/aaron/AppData/Roaming/Code/'
alias gwm='cd /mnt/c/Users/aaron/.glaze-wm/'
alias fl='cd /mnt/c/Users/aaron/AppData/Roaming/FlowLauncher/'
alias ff='cd /mnt/c/Users/aaron/AppData/Roaming/Mozilla/Firefox/Profiles/33dy0j9y.dev-edition-default/'
alias hypr='cd $HOME/.config/hypr/'
alias docs='cd $HOME/Documents/'
alias uni='cd $HOME/Documents/Universidad/'
alias n='nvim'
alias ..='cd ..'
alias sonarstart='/opt/sonarqube/bin/linux-x86-64/sonar.sh start'
alias sonarstop='/opt/sonarqube/bin/linux-x86-64/sonar.sh stop'
alias sonarstatus='/opt/sonarqube/bin/linux-x86-64/sonar.sh status'
alias sonar-scanner='/opt/sonarscanner/bin/sonar-scanner'

# Shell integration
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aarondev/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aarondev/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/aarondev/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/aarondev/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

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

export PATH=$PATH:/opt/sonar-scanner/bin
