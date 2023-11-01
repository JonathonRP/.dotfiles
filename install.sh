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
stow vim

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

sudo apt update && sudo apt install fontconfig -y

# nerdfont fonts for fish shell theme
font_list=("DaddyTimeMono")
select font_name in "${fons_list[@]}" "Quit";
  do
    if [ -n "$font_name" ]; then
      curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
      mkdir ~/.local/share/fonts
      unzip "$font_name.zip" -d "~/.local/share/fonts/$font_name"
      fc-cache ~/.local/share/fonts
      rm -rf "$font_name.zip"
      
      # git clone https://github.com/ryanoasis/nerd-fonts.git fonts --depth 1
      # cd fonts
      # ./install.sh DaddyTimeMono
      # cd .. && rm -rf fonts
      break
    if
  done
# vim -c ":PlugInstall"
