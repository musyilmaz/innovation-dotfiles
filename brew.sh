#!/usr/bin/env bash
source ./helpers/colors.sh
source ./brew/binaries.sh
source ./brew/casks.sh

# Ask for sudo upfront
sudo -v

while true; 
do 
  sudo -n true; 
  sleep 60; 
  kill -0 "$$" || exit;
done 2>/dev/null &

# update brew and upgrade already-installed binaries
brew update
brew upgrade

# Install binaries
echo "${Blue}===> ${White}Installing binaries..."
for i in ${binaries[@]}
do
  if brew ls --versions $i > /dev/null; then
    echo "${Red} ==> Skipping ${Blue}$i ${White}- already-installed..."
  else 
    brew install $i
  fi
done

# Install casks
echo "${Blue}===> ${White}Installing binaries..."
for i in ${casks[@]};
do
  if brew ls --versions --cask $i > /dev/null; then
    echo "${Red} ==> Skipping ${Blue}$i ${White}- already-installed..."
  else 
    brew install --cask $i
  fi
done

source ./brew/post_install.sh
