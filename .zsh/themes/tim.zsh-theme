# zsh theme -- tim
local return_code="%(?..%{$fg[red]%}%?)%{$reset_color%}"

# Getting ip here is of no use. Furthermore, the line below does not run on macos 
# IP=$(ip a | grep 'state UP' -A2 | tail -n 1 | awk '{print $2}' | cut -d/ -f 1)


# We've removed "$(git_super_status)" after the first "%{$reset_color%}", since it is too slow.
PREFIX=''
PROMPT=$'$PREFIX%{\033[33m%}%D{%F %H:%M:%S}%{$reset_color%} %{\033[32m%}%n@%m%{$fg[blue]%} %c%{$reset_color%} %!%{$reset_color%} \
$ '


# $(git_prompt_info)

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
