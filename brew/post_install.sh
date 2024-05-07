#!/usr/bin/env bash

# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Remove outdated versions from the cellar
brew cleanup
