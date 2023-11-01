# install fish shell
# sudo apt-add-repository ppa:fish-shell/release-3
# sudo apt update
# sudo apt install fish

# install ll on steroids
sudo apt-get install exa

# install stow dotfiles manager
sudo apt-get install -y stow

# stow files in .dotfiles
stow fish
# stow vim

# install vim
# apt-get install vim

# install nodejs
# curl -0- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# sudo nvm install --lts

# sudo nvm install node

# sudo nvm use node

# install npm dev tools
# sudo npm install -g typescript sass gulp

# command -v fish | sudo tree -a /ect/shells

# set default shell to fish
sudo chsh -s $(which fish) $USER

# install fisher fish minimal package manager
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# install plugins
sudo fisher update

# vim -c ":PlugInstall"
