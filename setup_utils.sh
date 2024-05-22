#!/bin/bash

# TODO: Have a mac build
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}" 
esac
echo "Machine type is ${machine}"

if [ "$machine" == "Mac" ]; then
  echo "Mac setup not supported yet."
  exit
fi

start_dir="$(pwd)"

os=$(cat /etc/os-release | grep -o -m 1 "Ubuntu") # m 1 just to get first match and stop

# TODO: have setups for other Linux systems
if [ "$os" == "Ubuntu" ]; then
  echo "Ubuntu detected. Completing setup"

  sudo apt-get update
  yes | sudo apt-get install build-essential

  # get latest node 
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
  nvm install node

  # fzf setup
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  cd ~/.fzf/
  yes | ./install
  cd "$start_dir"

  # neovim setup
  sudo snap install nvim --classic


  # tmux setup
  yes | sudo apt install tmux

  # python
  yes | sudo add-apt-repository ppa:deadsnakes/ppa
  yes | sudo apt update
  ues | sudo apt-get install python3.10 python3.10-dev python3.10-venv
  
  # zsh
  yes | sudo apt install zsh

  # oh-my-zsh and plugins
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  
  sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="jonathan"/g' ~/.zshrc 
  sed -i -e 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc 
  
  # aliases
  echo 'alias vim=nvim' >> ~/.zshrc
  echo 'alias v=vim' >> ~/.zshrc

  echo "Run source ~/.zshrc manually"
else
  echo "Not Ubuntu detected. os is $os"
fi

