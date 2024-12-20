#!/bin/bash

. /etc/os-release

case $ID in
  ubuntu)
    DEBIAN_FRONTEND=noninteractive
    
    # install deps
    sudo apt update -q --no-allow-insecure-repositories \
    && sudo apt install -y --no-install-recommends \
    curl \
    fontconfig \
    exa \
    stow \
    xdg-utils
    
    # ---fish shell setup---
    if ! command -v fish 2>&1 >/dev/null; then
        echo "installing fish"
        sudo apt-add-repository ppa:fish-shell/release-3
        sudo apt update
        sudo apt install -y --no-install-recommends fish
        echo "done - fish installed"
    fi

    # install fisher fish minimal package manager
    if ! fish -c "type -q fisher"; then
      echo "installing fisher"
      fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher </dev/null'
      if [ "${USERNAME}" != "root" ]; then
        sudo -u $USERNAME -c fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher </dev/null'
      fi
      fish -c "fisher -v"
      echo "done - fisher installed"
    fi

    # set default shell to fish
    # command -v fish | sudo tree -a /ect/shells
    # sudo chsh -s $(which fish) $USER

    # ---vim setup---
    # echo "install vim"
    # apt-get install vim

    # ---nu shell setup---
    if ! command -v nu 2>&1 >/dev/null; then
        echo "installing nu"
        sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        sudo apt install -y --no-install-recommends build-essential pkg-config libssl-dev
        
        # Add .cargo/bin to PATH
        ENV PATH="/root/.cargo/bin:${PATH}"
        # . "$HOME/.cargo/env"
        fish -c 'source $HOME/.cargo/env.fish'

        cargo install nu
        echo "done - nu installed"
    fi

    # ---nvim setup---
    if ! command -v bob 2>&1 >/dev/null; then
      cargo install bob-nvim

    fi

    if ! command -v nvim 2>&1 >/dev/null; then
      bob install latest
      bob use latest

      PATH=$PATH:/home/jperry/.local/share/bob/nvim-bin
      fish -c 'fish_add_path /home/jperry/.local/share/bob/nvim-bin'
    fi

    # ---dotfiles setup---
    echo "setup .dotfiles"

    # if this is a codespace, link automatically cloned dotfiles repo to the expected DOTFILES_PATH
    # https://docs.github.com/en/codespaces/troubleshooting/troubleshooting-personalization-for-codespaces#troubleshooting-dotfiles
    # simlink config files from .dotfiles using stow
    if [[ "$CODESPACES" = "true" ]] && [[ -d /workspaces/.codespaces/.persistedshare/dotfiles ]]; then
      # location of the *full repo* (defaults to ~/.dotfiles)
      stow vim lazygit gitcz fish nu --adopt -vv -t $HOME
    else
      stow vim lazygit gitcz fish nu --adopt -vv
    fi
    
    # undo stashing overwrite
    git restore .
    # git --reset hard

    echo "done - .dotfiles installed"

    # ---config fish---
    # fish -c "source ~/.config/fish/config.fish" - fish config is available now
    echo "installing/updating plugins and configure tide"
    fish -c "fisher update </dev/null; tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Few icons' --transient=Yes"

    # ---config vim---
    # vim -c ":PlugInstall"

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

    # ---lazygit setup---
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    
    mkdir lazygit-cli
    cd ./lazygit-cli/
    
    echo "downloading lazygit-cli ${LAZYGET_VERSION}"
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    
    echo "installing lazygit-cli"
    sudo install lazygit /usr/local/bin
    
    # clean up lazygit
    cd ../
    rm -rf lazygit-cli
    echo "done - lazygit-cli installed"
    
    # --- dev js/ts lib packages setup ---
    echo "installing dev (git-cz)"
    package_manager=""
    
    # Check for npm
    if command -v npm 2>&1 >/dev/null; then
      package_manager="npm"
    # Check for bun
    elif command -v bun 2>&1 >/dev/null; then
      package_manager="bun"
    # Check for deno
    elif command -v deno 2>&1 >/dev/null; then
      package_manager="deno"
      else
        echo "No supported package manager found (npm, bun, or deno). installing node/npm"
        
        # install nodejs
        curl -0- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        
        sudo nvm install --lts
        
        sudo nvm install node
        
        sudo nvm use node
    
        package_manager="npm"
    fi
    
    case "$package_manager" in
      "deno")
        deno install -g npm:git-cz
        ;;
      "npm" | "bun")
        # install npm dev tools
        # sudo npm install -g typescript sass gulp
        "$package_manager" install -g git-cz
        ;;
    esac

    echo "done - (git-cz) installed"
    ;;
  
  *)
    echo "This is an unknown distribution."
    ;;
esac
