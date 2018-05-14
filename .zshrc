# some utilities
source $HOME/.zsh/utils.zsh

# antigen plugins {
source $HOME/.zsh/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle autojump
[ $OS_DISTRIBUTION = 'ubuntu' ] && source /usr/share/autojump/autojump.sh

antigen theme zxytim/dotfiles .zsh/themes/tim

antigen apply
# }


# aliases {
alias -g L='| less'
alias -g JL='| jq | less'
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

alias a3='source ~/anaconda3/bin/activate'
alias c3='~/anaconda3/bin/conda'

# http proxy
alias set_proxy='source ~/bin/default_proxy.source'
alias unset_proxy='unset http_proxy https_proxy'

if [ $OS_DISTRIBUTION = 'arch' ]; then
	alias yS='yaourt -S --noconfirm --needed'
	alias ySs='yaourt -Ss'
	alias pS='sudo pacman -S --noconfirm --needed'
	alias pSyu='sudo pacman -Syu --noconfirm --needed'
	alias pSs='sudo pacman -Ss'
fi

# }

# key bindings {

# default beginning-of-line is ctrl-a, which conflicted with keybinding ctrl-a
# used in tmux. 
bindkey '^D' beginning-of-line  # ctrl-d 

# }


# Developement Settings {
export PATH=$HOME/bin:$HOME/.local/bin:$PATH
[ -f $HOME/.zsh/paths.zsh ] && source $HOME/.zsh/paths.zsh 
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

if [ $OS_DISTRIBUTION = 'arch' ]; then
	if ! pgrep -u $USER ssh-agent > /dev/null; then
	    [ -d ~/.config ] || mkdir -v ~/.config
	    ssh-agent > ~/.config/ssh-agent-thing
	    echo "ssh-agent started"
	fi
	eval $(<~/.config/ssh-agent-thing) > /dev/null
fi

# }

safe_source ~/.fzf.zsh 
safe_source ~/.zsh_local

export MAKEFLAGS='-j4'
