### Starship setting prompt
starship init fish | source

### No greeting
set -g fish_greeting

### Alias
alias py='python3'
alias update='sudo apt update && sudo apt upgrade -y'
alias react='cd /home/aarondev/Documents/Code/PersonalProjects/reactZeroToHero'
alias matrix='cd /home/aarondev/Documents/Code/Matrix'
alias work='cd /home/aarondev/Documents/Code/PersonalProjects/Work/'
alias personal='cd /home/aarondev/Documents/Code/PersonalProjects/'
alias dots='cd /home/aarondev/Documents/dotfiles/'
alias portfolio='cd /home/aarondev/Documents/Code/PersonalProjects/portfolio/'
alias notes='cd /mnt/d/aaronDev/Documents/127.0.0.1'

### CONDA PATH
set -x PATH $PATH /home/aarondev/anaconda3/bin/

### Node.js route to PATH
set -x PATH $PATH /home/aarondev/.nvm/versions/node/v20.11.0/bin/


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/aarondev/anaconda3/bin/conda
    eval /home/aarondev/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/home/aarondev/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/aarondev/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /home/aarondev/anaconda3/bin $PATH
    end
end
# <<< conda initialize <<<
