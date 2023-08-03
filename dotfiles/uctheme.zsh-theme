# current time with milliseconds
current_time() {
   echo "%*"
}

PROMPT='%{$BG[128]%}%B %n %b%{$reset_color%} %{$FG[225]%}in %{$BG[202]%}%B %0~ %b%{$reset_color%} $(git_prompt_info)'
PROMPT+="%(?:%{$FG[153]%}ƛ %{$reset_color%}:%{$FG[196]%}ƛ %{$reset_color%} )"

RPROMPT='$(current_time)'

ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg_bold[blue]%}Branch:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}🔓"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[yellow]%}🔒"
