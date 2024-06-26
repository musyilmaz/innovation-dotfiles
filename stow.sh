#!/usr/bin/env bash

configs=(
  alacritty
  git
  nvim
  starship
  tmux
  zsh
)

target_dir=~

for c in ${configs[@]}
do
  echo "${Blue}===> ${White}Creating config symlinks for $c..."
  stow -t $target_dir $c
done
