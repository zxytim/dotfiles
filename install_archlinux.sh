#!/bin/bash -e
set -x

INSTALL_LOG_DIR="$HOME/.install-log"

mkdir -p "$INSTALL_LOG_DIR"

PACMAN_INSTALL="sudo pacman -S --needed --noconfirm"
YAOURT_INSTALL="yaourt -S --needed --noconfirm"


# install basic packages
$PACMAN_INSTALL \
	base-devel \
	wget \
	lxdm zsh tmux \
	xmonad xmonad-contrib xmonad-utils xmobar \
	neovim python-pip python-jedi python-neovim \
	xclip xsel grub efibootmgr os-prober \
	jq clang \
	wpa_supplicant dialog \
	acpi linux-lts linux-lts-headers openssh rsync \
	git tig the_silver_searcher \
	fcitx fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-qt4 fcitx-qt5 \
	fcitx-rime fcitx-table-extra fcitx-table-other \
	xscreensaver redshift notification-daemon \
	xorg xorg-drivers \
	sakura firefox chromium \
	alsa-firmware alsa-lib alsa-oss alsaplayer alsa-plugins alsa-tools alsa-utils \
	networkmanager \
	autossh \

sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

$YAOURT_INSTALL \
	google-chrome


# basic fonts
$PACMAN_INSTALL $(sudo pacman -Ss 'ttf' | grep '^[a-z]' | cut -d / -f 2 | cut -d' ' -f 1 | grep '^ttf')


# setup git
git config --global user.email zxytim@gmail.com
git config --global user.name 'Xinyu Zhou'

# gui settings
# xmonad
xmonad --recompile
# lxdm
sudo systemctl enable lxdm

# install yaourt
YAOURT_DONE="$INSTALL_LOG_DIR/yaourt.done"
if [ ! -e "$YAOURT_DONE" ]; then
	curl https://raw.githubusercontent.com/zxytim/yaourt-install/master/install.sh | bash
	touch "$YAOURT_DONE"
fi


DOTFILES_DONE="$INSTALL_LOG_DIR/dotfiles.done"
if [ ! -e "$DOTFILES_DONE" ]; then
	cd ~
	git init
	git remote add origin https://github.com/zxytim/dotfiles.git
	git pull origin master
	git checkout master

	# then ignore everything
	echo '*' >> ~/.git/info/exclude
	touch "$DOTFILES_DONE"
fi



# setup zsh
ZSH_DONE="$INSTALL_LOG_DIR/zsh.done"
if [ ! -e "$ZSH_DONE" ]; then
	echo "Install zsh plugins ..."
	zsh -c 'source ~/.zshrc' || true

	sudo chsh -s /usr/bin/zsh $USER
	touch "$ZSH_DONE"
fi

VIM_DONE="$INSTALL_LOG_DIR/vim.done"
if [ ! -e "$VIM_DONE" ]; then
	ln -svf $(which nvim) ~/bin/vim
	# Install vim-plug
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	sudo pacman -S cmake  # needed to compile YCM

	# fix 

	nvim +PlugInstall +qall
	touch "$VIM_DONE"
fi


set +x

echo "####### Postprocessing #######"
echo "1. Setting up fcitx: add following environment variables to /etc/profile"
echo "   export GTK_IM_MODULE=fcitx"
echo "   export QT_IM_MODULE=fcitx"
echo "   export XMODIFIERS=@im=fcitx"
