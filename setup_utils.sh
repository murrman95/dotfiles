#!/bin/bash


unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=Git;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "Machine type is ${machine}"

os=$(cat /etc/os-release | grep -o -m 1 "Ubuntu")

if [ "$os" == "Ubuntu" ]; then
  echo "Ubuntu detected. Completing setup"
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

  source ~/.bashrc
else
  echo "Not Ubuntu detected. os is $os"
fi

