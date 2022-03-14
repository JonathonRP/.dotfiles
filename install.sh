# install fish shell
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

# install ll on steroids
sudo apt install exa

# install stow dotfiles manager
sudo apt-get install -y stow

# stow files in .dotfiles
stow fish
stow vim

# install vim
sudo apt install vim

# install nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs

sudo npm install -g n

sudo n install 10.9.0

sudo n install 14.0.0

sudo n use 14.0.0

# install npm dev tools
sudo npm install -g typescript sass gulp

command -v fish | sudo tree -a /ect/shells

# set default shell to fish
sudo chsh -s $(which fish) $USER

# install fisher fish minimal package manager
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# install plugins
sudo fisher update

vim -c ":PlugInstall"