# How to install

## Setup git repo
```
# set the repo root as home
cd ~
git init
git remote add origin git@github.com:zxytim/dotfiles.git
git pull origin master
git checkout master


# then ignore everything
echo '*' >> ~/.git/info/exclude
```

## MacOS
Install [Meslo Nerd Font patched for Powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)

Install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


Install packages
```
brew install tmux neovim autojump tig htop cmake python
python3 -m pip install -U pip
python3 -m pip install asciichartpy colored click numpy pynvim
```

Install vim-plug plugins
```
nvim +PlugInstall
```

Compile [YCM](https://github.com/ycm-core/YouCompleteMe)
```
~/.vim/plugged/YouCompleteMe
```

# Deprecated (Sections below are not been maintained anymore)
## (Ubuntu) Supersede vim with nvim
```
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
```

## Install OS-specific dependencies

### Ubuntu
```
sudo apt update
sudo apt install -y python-dev python3-dev python-pip python3-pip jq silversearcher-ag tig
pip3 install --user neovim jedi
pip install --user neovim jedi
```

### Arch Linux
```
TODO
pip install --user neovim jedi
```



# How to Add Files
```
git add -f some_file
```


# TODOs
+ Add some screenshots
