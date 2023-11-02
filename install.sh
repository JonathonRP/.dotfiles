DEBIAN_FRONTEND=noninteractive

# install fish shell
# sudo apt-add-repository ppa:fish-shell/release-3
# sudo apt update
# sudo apt install fish

# install deps
sudo apt update -q --no-allow-insecure-repositories \
&& sudo apt install -y --no-install-recommends \
curl \
fontconfig \
exa \
stow

# install fisher fish minimal package manager
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# apt-get install vim

# install nerdfont fonts for fish shell theme
font_list=("DaddyTimeMono")
for font_name in $font_list
do
  echo "Starting download ${font_name} nerd font"
  if [ -n "$font_name" ]; then
      echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.zip"
      curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.zip"
      echo "creating fonts folder: ~/.local/share/fonts"
      mkdir ~/.local/share/fonts
      echo "unzip the ${font_name}.zip"
      unzip "${font_name}.zip" -d ~/.local/share/fonts/
      fc-cache ~/.local/share/fonts
      rm -rf "${font_name}.zip"
      echo "done!"
      
      # git clone https://github.com/ryanoasis/nerd-fonts.git fonts --depth 1
      # cd fonts
      # ./install.sh DaddyTimeMono
      # cd .. && rm -rf fonts
      break
  fi
done

# stow from .dotfiles
stow fish vim

# fish setup
# command -v fish | sudo tree -a /ect/shells
fisher update
# set default shell to fish
sudo chsh -s $(which fish) $USER

# vim setup
# vim -c ":PlugInstall"

# dev setup
# install nodejs
# curl -0- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# sudo nvm install --lts

# sudo nvm install node

# sudo nvm use node

# install npm dev tools
# sudo npm install -g typescript sass gulp
