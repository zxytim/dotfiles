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

## Supersede vim with nvim
```
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
```

## Install OS-specific dependencies

### Ubuntu
```
sudo apt install python-dev python3-dev python-pip python3-pip net-stat jq silversearcher-ag tig
pip3 install --user neovim jedi
pip install --user neovim --jedi
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
