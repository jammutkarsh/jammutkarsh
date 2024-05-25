PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/opt/curl/bin:/Users/utc/.local/bin:$HOME/go/bin:$HOME/Dotfiles/scripts"
export PATH

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

export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPLETION="~/.oh-my-zsh/completions/"
ZSH_THEME="uctheme"
source $ZSH/oh-my-zsh.sh

export GOPATH="$HOME/go"

source $HOME/dotfiles/alias
export HISTCONTROL="erasedupes:ignoredupes"
export HISTIGNORE="ls*:history:code*"

#CMD: atuin or ctrl + r
#COX: replacement for custom hst command
eval "$(atuin init zsh --disable-up-arrow)"
test -e /Users/utc/.iterm2_shell_integration.zsh && source /Users/utc/.iterm2_shell_integration.zsh || true
