# long history
HISTSIZE=10000000
SAVEHIST=10000000

fpath+=~/.zfunc

# some utilities
source $HOME/.zsh/utils.zsh

# antigen plugins {
source $HOME/.zsh/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle olivierverdier/zsh-git-prompt
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle autojump
[[ $OS_DISTRIBUTION == 'ubuntu' ]] && source /usr/share/autojump/autojump.sh

antigen theme zxytim/dotfiles .zsh/themes/tim

antigen apply
# }


# aliases {
alias -g L='| less'
alias -g JL='| jq . | less'
alias -g CL='| pygmentize | less'
alias -g G='| grep'

alias m='make'
alias mc='make clean'
alias mt='make train'
alias me='make eval'
alias mi='make info'
alias mtb='make tensorboard'
alias ms='make serve'

alias ta='tmux a'
alias tad='tmux a -d'

alias sv='sudo vim'
alias vi='vim'
alias v=vim
alias c='cat'

alias ip3='ipython3'

alias rf='readlink -f'

alias a3='source ~/bin/a3'
alias c3='~/anaconda3/bin/conda'

# http proxy
alias set_proxy='source ~/bin/default_proxy.source'
alias unset_proxy='unset http_proxy https_proxy'

if [[ $OS_DISTRIBUTION == 'arch' ]]; then
	alias yS='yaourt -S --noconfirm --needed'
	alias ySs='yaourt -Ss'
	alias pS='sudo pacman -S --noconfirm --needed'
	alias pSyu='sudo pacman -Syu --noconfirm --needed'
	alias pSs='sudo pacman -Ss'
fi

alias iotop='sudo iotop'

# }

# key bindings {

# default beginning-of-line is ctrl-a, which conflicted with keybinding ctrl-a
# used in tmux. 
bindkey '^D' beginning-of-line  # ctrl-d 

expand-aliases() {
    unset 'functions[_expand-aliases]'
    functions[_expand-aliases]=$BUFFER
    (($+functions[_expand-aliases])) &&
	BUFFER=${functions[_expand-aliases]#$'\t'} &&
	CURSOR=$#BUFFER
}

zle -N expand-aliases
bindkey '\e^E' expand-aliases  # ctrl-alt-e
# }


# Developement Settings {
export PATH=$HOME/bin:$HOME/.local/bin:$PATH
safe_source $HOME/.zsh/paths.zsh 
# }


# configuration shortcut {
conf() {
	case $1 in 
		xmonad)		vim ~/.xmonad/xmonad.hs ;;
		tmux)		vim ~/.tmux.conf ;;
		vim)		vim ~/.config/nvim/init.vim ;;
		zsh)		vim ~/.zshrc ;;
		*)		echo "Unknown application $1" ;;
	esac
}
# }


# ssh-agent {
#
# On Ubuntu, dbus will start ssh-agent

if [[ $OS_DISTRIBUTION == 'arch' ]]; then
	if ! pgrep -u $USER ssh-agent > /dev/null; then
	    [ -d ~/.config ] || mkdir -v ~/.config
	    ssh-agent > ~/.config/ssh-agent-thing
	    echo "ssh-agent started"
	fi
	eval $(<~/.config/ssh-agent-thing) > /dev/null
fi

# }
#


# npm packages
export PATH=$HOME/.local/npm/bin:$PATH

export MAKEFLAGS='-j4'
export VISUAL='vim'
export EDITOR='vim'


# set tmux pane title to current directory name
# supported only for tmux version >= 2.3
TMUX_VERSION=$(tmux -V | cut -d ' ' -f 2)
if version_compare_greater_equal "$TMUX_VERSION" 2.3; then
    function set_tmux_title () {
	printf '\033]2;'"$1"'\033\\'
    }
     
    function auto_tmux_title() {
	emulate -L zsh
	printf '\033]2;'"${PWD:t}"'\033\\'
    }
     
    auto_tmux_title
    chpwd_functions=(${chpwd_functions[@]} "auto_tmux_title")
fi


safe_source ~/.fzf.zsh 

gshow() {
    git log --graph --color=always \
	--format="%C(auto)%h%d %s %C(black)%C(bold)%cr %C(bold blue)<%an>%Creset" "$@" |
	fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
	--bind "ctrl-m:execute:
    (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF' 
    {} 
    FZF-EOF" \
	--preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
}


# peotry dependency manager for python
export PATH="$HOME/.poetry/bin:$PATH"

# execute ~/.zsh_local at the end
safe_source ~/.zsh_local

