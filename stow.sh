#!/usr/bin/env bash

configs=(
  alacritty
  git
  herdr
  nvim
  starship
  tmux
  zsh
  aider
)

target_dir=~

for c in ${configs[@]}
do
  echo "${Blue}===> ${White}Creating config symlinks for $c..."
  stow -t $target_dir $c
done
