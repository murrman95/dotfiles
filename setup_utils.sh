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

  # neovim setup
  sudo snap install nvim

  echo 'alias vim=nvim' >> ~/.bashrc
  echo 'alias v=vim' >> ~/.bashrc

  # tmux setup
  sudo apt install tmux

  # python
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt update
  sudo apt-get install python3.10 python3.10-dev python3.10-venv

  source ~/.bashrc
else
  echo "Not Ubuntu detected. os is $os"
fi

