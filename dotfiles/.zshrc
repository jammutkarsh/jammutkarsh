export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPLETION="~/.oh-my-zsh/completions/"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/Users/utc/.local/bin:$PATH"

export PATH=$PATH:/Users/utc/Dotfiles/scripts
export PATH=$PATH:/Users/utc/go/bin

ZSH_THEME="uctheme"

plugins=(
        git
        golang
        docker
        zsh-autosuggestions
        zsh-syntax-highlighting
        multipass
        npm
        node
)

source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/alias

# CMD -> command
# COX -> command explanation

#CMD: atuin or ctrl + r
#COX: replacement for custom hst command
eval "$(atuin init zsh --disable-up-arrow)"
