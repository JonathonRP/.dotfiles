#!/bin/bash

DEBIAN_FRONTEND=noninteractive

# install deps
sudo apt update -q --no-allow-insecure-repositories \
&& sudo apt install -y --no-install-recommends \
curl \
fontconfig \
exa \
stow

# install nerdfont fonts for fish shell theme
font_list=("Meslo")
for font_name in $font_list
do
  echo "Starting download ${font_name} nerd font"
  if [ -n "$font_name" ]; then
      curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.zip"
      mkdir -p ~/.local/share/fonts
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
stow vim fish --adopt

# ---fish setup---
# install fish shell
# sudo apt-add-repository ppa:fish-shell/release-3
# sudo apt update
# sudo apt install fish

# set default shell to fish
# command -v fish | sudo tree -a /ect/shells
# sudo chsh -s $(which fish) $USER

# install fisher fish minimal package manager
# fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'

# if [ "${USERNAME}" != "root" ]; then
#   su $USERNAME -c 'fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"'
# fi

# fish -c 'fundle install'
# fish -c 'fisher update'
# fish -c 'tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Few icons' --transient=Yes'

# ---vim setup---
# apt-get install vim
# vim -c ":PlugInstall"

# dev setup
# install nodejs
# curl -0- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# sudo nvm install --lts

# sudo nvm install node

# sudo nvm use node

# install npm dev tools
# sudo npm install -g typescript sass gulp
